//
//  UserService.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/29/21.
//

import Foundation
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {

    static func fetchUser(completion: @escaping(User) -> Void) {
     
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snap, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let dictionary = snap?.data() else { return }
            let user             = User(dictionary: dictionary)
            completion(user)
        }
    }

    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snap, error in
            guard let snap = snap else { return }
            let users      = snap.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snap, error in
            guard let isFollowed = snap?.exists else { return }
            completion(isFollowed)
        }
    }
    
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snap, _ in
            let followers = snap?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snap, _ in
                let following = snap?.documents.count ?? 0
                
                COLLECTION_POSTS.document()
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
    
}
