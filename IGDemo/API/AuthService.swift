//
//  AuthService.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/11/21.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email       : String
    let password    : String
    let fullname    : String
    let username    : String
    let profileImage: UIImage
}


struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        
        //upload image to storage first to gain access to image url
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String : Any] = ["email"             : credentials.email,
                                            "fullname"          : credentials.fullname,
                                            "profileImageUrl"   : imageUrl,
                                            "username"          : credentials.username,
                                            "uid"               : uid]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
        
    }
    
}
