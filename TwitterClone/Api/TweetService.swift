//
//  TweetService.swift
//  TwitterClone
//
//  Created by made reihan on 28/03/24.
//

import Firebase

class TweetService {
    static let shared = TweetService()

    func uploadTweet(caption: String, completion: @escaping (Error?,DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "likes": 0, "retweets": 0, "caption": caption] as [String: Any]
    
        REF_TWEETS.childByAutoId().updateChildValues(values,withCompletionBlock: completion)
    }
    
    func fetchTweet(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user:user, tweetID: tweetID, dictionary: dictionary )
                tweets.append(tweet)
                completion(tweets.reversed())
            }
        }
    }
}
