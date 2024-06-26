//
//  Tweet.swift
//  TwitterClone
//
//  Created by made reihan on 28/03/24.
//

import Foundation

class Tweet {
    let caption: String
    let tweetID: String
    let uid:String
    let likes:String
    var timestamp:Date!
    let retweetCount:Int
    let user: User
    
    init(user: User,tweetID: String, dictionary: [String:Any]) {
        self.tweetID = tweetID
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? String ?? ""
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
