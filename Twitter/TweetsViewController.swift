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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
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
