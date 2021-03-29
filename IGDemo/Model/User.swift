//
//  User.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/29/21.
//

import Foundation
import Firebase

struct User {
    
    let email           : String
    let fullname        : String
    let profileImageUrl : String
    let username        : String
    let uid             : String
    
    var isFollowing = false
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(dictionary: [String : Any]) {
        self.email              = dictionary["email"] as? String ?? ""
        self.fullname           = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl    = dictionary["profileImageUrl"] as? String ?? ""
        self.username           = dictionary["username"] as? String ?? ""
        self.uid                = dictionary["uid"] as? String ?? ""
    }
    
}
