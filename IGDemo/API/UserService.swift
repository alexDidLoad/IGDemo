//
//  UserService.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/29/21.
//

import Foundation
import Firebase

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
    
}
