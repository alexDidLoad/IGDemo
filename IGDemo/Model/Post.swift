//
//  Post.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/30/21.
//

import UIKit
import Firebase

struct Post {
    
    var caption         : String
    var likes           : Int
    let imageUrl        : String
    let ownerUid        : String
    let timestamp       : Timestamp
    let postID          : String
    let ownerImageUrl   : String
    let ownerUsername   : String
    
    init(postID: String, dictionary: [String : Any]) {
        self.caption       = dictionary["caption"] as? String ?? ""
        self.likes         = dictionary["likes"] as? Int ?? 0
        self.imageUrl      = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid      = dictionary["ownerUid"] as? String ?? ""
        self.timestamp     = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.postID        = postID
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
