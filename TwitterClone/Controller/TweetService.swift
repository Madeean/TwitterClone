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
        
        let ref = REF_TWEETS.childByAutoId()
    
        ref.updateChildValues(values) { (err, ref) in
            guard let tweetID = ref.key else {return}
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
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
    
    func fetchTweets(forUser user:User, completion: @escaping([Tweet]) -> Void ) {
        var tweets = [Tweet]()
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            let tweetID = snapshot.key
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String:Any] else {return}
                guard let uid = dictionary["uid"] as? String else {return}
                
                UserService.shared.fetchUser(uid: uid) { user in
                    let tweet = Tweet(user:user, tweetID: tweetID, dictionary: dictionary )
                    tweets.append(tweet)
                    completion(tweets.reversed())
                }
            }
        }
    }
}
