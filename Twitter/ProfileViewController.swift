//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Mike Lam on 11/5/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var headerScreenNameLabel: UILabel!
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var headerProfileImageView: UIImageView!
    @IBOutlet weak var headerImageView: UIImageView!
    var user: User!
    var tweets: [Tweet]! = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidAppear(_ animated: Bool) {
        TwitterClient.sharedInstance?.getUserTweets(id: user.id!, success: { (response: [Tweet]) in
            print("tweets: \(response)")
            self.tweets = response
            self.tableView.reloadData()
            }, failure: { (error:Error) in
                print("error: \(error)")
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
        tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetViewCell", for: indexPath) as! TweetViewCell
        let tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        print("cell.profile: \(cell.profileImageView.image)")
        return cell
    }
}

extension ProfileViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
