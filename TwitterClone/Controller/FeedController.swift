//
//  FeedController.swift
//  TwitterClone
//
//  Created by made reihan on 23/03/24.
//

import SDWebImage
import UIKit

private let reuseIdentifier = "TweetCell"

class FeedController: UICollectionViewController {
    // MARK: - PROPERTIES

    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet](){
        didSet{collectionView.reloadData()}
    }

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchTweets()
    }

    // MARK: - API
    func fetchTweets(){
        TweetService.shared.fetchTweet { tweets in
            self.tweets = tweets
        }
    }
    
    // MARK: - HELPERS

    func configureUI() {
        view.backgroundColor = .white

        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
    }

    func configureLeftBarButton() {
        guard let user = user else { return }

        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
}


extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
