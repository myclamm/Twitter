//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Mike Lam on 10/31/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet : Tweet!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var delegate: TweetsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "@\(tweet.username!)"
        tweetTextLabel.text = tweet.text
        nameLabel.text = tweet.name
        if let profileImageURL = tweet.profileImageURL {
            profileImageView.setImageWith(profileImageURL)
        } else {
            profileImageView.image = nil
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyButton(_ sender: TwitterButton) {
        sender.animateOnClick()
        TwitterClient.sharedInstance?.reTweet(id: tweet.id!, success: {()->() in
            print("Successful retweet!")
            }, failure: {(error:Error)->() in
                print("Failed to retweet: \(error)")
        })
    }
    
    @IBAction func onFavoriteButton(_ sender: TwitterButton) {
        sender.animateOnClick()
        TwitterClient.sharedInstance?.favoriteTweet(id: tweet.id!, success: {()->() in
            print("Successfully favorited tweet!")
            }, failure: {(error:Error)->() in
                print("Failed to favorite tweet: \(error)")
        })
 
    }
    
    @IBAction func onRetweetButton(_ sender: TwitterButton) {
        sender.animateOnClick()
        TwitterClient.sharedInstance?.reTweet(id: tweet.id!, success: {()->() in
            print("Successful retweet!")
            }, failure: {(error:Error)->() in
                print("Failed to retweet: \(error)")
        })
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "replySegue" {
            let navVC = segue.destination as! UINavigationController
            let destinationViewController = navVC.viewControllers.first as! ComposeViewController
            destinationViewController.delegate = self.delegate
            destinationViewController.replyToId = tweet.id 
            destinationViewController.replyToUser = tweet.username
        }
    }
    

}
