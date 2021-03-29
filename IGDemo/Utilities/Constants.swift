//
//  Constants.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit
import Firebase

//MARK: - API Ref

let COLLECTION_USERS     = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")


//MARK: - Image Constants

enum SFSymbols {
    
    static let house        = UIImage(systemName: "house")!
    static let houseFill    = UIImage(systemName: "house.fill")!
    static let search       = UIImage(systemName: "magnifyingglass")!
    static let add          = UIImage(systemName: "plus.square")!
    static let addFill      = UIImage(systemName: "plus.square.fill")!
    static let heart        = UIImage(systemName: "heart")!
    static let heartFill    = UIImage(systemName: "heart.fill")!
    static let person       = UIImage(systemName: "person")!
    static let personFill   = UIImage(systemName: "person.fill")!
    static let emptyPhoto   = UIImage(systemName: "photo")!
    static let comment      = UIImage(systemName: "bubble.right")!
    static let send         = UIImage(systemName: "paperplane")!
    static let bookmark     = UIImage(systemName: "bookmark")!
    static let ellipsis     = UIImage(systemName: "ellipsis")!
    static let gridFill     = UIImage(systemName: "square.grid.3x3.fill")!
    static let list         = UIImage(systemName: "list.bullet")!
    static let bookmarkFill = UIImage(systemName: "bookmark.fill")!
}

enum ImageAssets {
    
    static let instagramLogo = UIImage(named: "Instagram")
    static let addPhoto      = UIImage(named: "addPhoto")
}
