//
//  TweetsViewControllersViewController.swift
//  Twitter
//
//  Created by Mike Lam on 10/30/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    var tweets: [Tweet]! = []
    
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var headerFollowersLabel: UILabel!
    @IBOutlet weak var headerFollowingLabel: UILabel!
    @IBOutlet weak var headerTweetsLabel: UILabel!
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var headerScreenNameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerProfileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupHeaderView()
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
        updateTweets()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func updateTweets() {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            }, failure: { (error: Error)-> () in
                print(error.localizedDescription)
        })
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshControlAction(refreshControl:)),
                                 for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    func setupHeaderView() {
        statsView.layer.borderWidth = 1
        statsView.layer.borderColor = UIColor.gray.cgColor
        headerNameLabel.text = User.currentUser?.name!
        headerNameLabel.layer.zPosition = 1
        headerScreenNameLabel.text = "@\((User.currentUser?.screenname!)!)"
        headerScreenNameLabel.layer.zPosition = 1
        
        headerTweetsLabel.text = String((User.currentUser?.tweetCount)! as Int)
        headerFollowersLabel.text = String((User.currentUser?.followersCount)! as Int)
        headerFollowingLabel.text = String((User.currentUser?.followingCount)! as Int)
        
        if let profileImageURL = User.currentUser?.profileUrl {
            headerProfileImageView.setImageWith(profileImageURL)
            headerProfileImageView.layer.zPosition = 1
        } else {
            headerProfileImageView.image = nil
        }
        
        if let headerImageURL = User.currentUser?.headerPicUrl {
            headerImageView.setImageWith(headerImageURL)
        } else {
            headerImageView.image = nil
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            }, failure: { (error: Error)-> () in
                print(error.localizedDescription)
                self.refreshControl.endRefreshing()
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeSegue" {

            let navVC = segue.destination as! UINavigationController
            let destinationViewController = navVC.viewControllers.first as! ComposeViewController
            
            destinationViewController.delegate = self
        }
        
        if segue.identifier == "detailSegue" {
            let cell = sender as! TweetViewCell
            let indexPath = tableView.indexPath(for: cell)
            let selectedTweet = self.tweets[(indexPath?.row)!]
            let destinationViewController = segue.destination as! TweetDetailViewController
            
            destinationViewController.tweet = selectedTweet
            // Pass delegate, so that tweetdetailviewcontroller can later pass delegate to composeviewcontroller...there must be a better way to do this
            destinationViewController.delegate = self
            
        }
        
    }
}

// MARK: - UITableViewDataSource

extension TweetsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetViewCell", for: indexPath) as! TweetViewCell
        let tweet = self.tweets[indexPath.row]
        
        cell.tweet = tweet
        print("cell.profile: \(cell.profileImageView.image)")
        return cell
    }
}

extension TweetsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
