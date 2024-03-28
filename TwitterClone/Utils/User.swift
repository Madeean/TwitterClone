//
//  User.swift
//  TwitterClone
//
//  Created by made reihan on 26/03/24.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl:URL?
    let uid: String
    
    init(uid:String,dictionary: [String: AnyObject]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = uid
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else {return}
            self.profileImageUrl = url
        }
    }
}