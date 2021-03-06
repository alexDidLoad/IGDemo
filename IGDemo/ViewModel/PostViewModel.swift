//
//  PostViewModel.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/31/21.
//

import Foundation


struct PostViewModel {
    
    private let post: Post
    
    var imageUrl            : URL? { return URL(string: post.imageUrl) }
    var caption             : String { return post.caption }
    var likes               : Int { return post.likes }
    var userProfileImageUrl : URL? { return URL(string: post.ownerImageUrl)}
    var username            : String { return post.ownerUsername}
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    init(post: Post) {
        self.post = post
    }
    
}
