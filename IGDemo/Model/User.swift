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
    
    var stats           : UserStats!
    var isCurrentUser   : Bool { return Auth.auth().currentUser?.uid == uid }
    var isFollowing     = false
   
    
    init(dictionary: [String : Any]) {
        self.email              = dictionary["email"] as? String ?? ""
        self.fullname           = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl    = dictionary["profileImageUrl"] as? String ?? ""
        self.username           = dictionary["username"] as? String ?? ""
        self.uid                = dictionary["uid"] as? String ?? ""
        self.stats              = UserStats(followers: 0, following: 0, posts: 0)
    }
}


struct UserStats {
    let followers   : Int
    let following   : Int
    let posts     : Int
}
