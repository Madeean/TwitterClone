//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by made reihan on 30/03/24.
//

import Foundation
import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageUrl:URL? {
        return tweet.user.profileImageUrl
    }
    
    var timestamp: String {
        let format = DateComponentsFormatter()
        format.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        format.maximumUnitCount = 1
        format.unitsStyle = .abbreviated
        let now = Date()
        return format.string(from: tweet.timestamp, to: now) ?? "0s"
    }
    
    var userInfoText: NSMutableAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font:UIFont.systemFont(ofSize: 14), .foregroundColor:UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ・ \(timestamp)", attributes: [.font:UIFont.systemFont(ofSize: 14), .foregroundColor:UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
}
