//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Mike Lam on 10/31/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        usernameLabel.text = User.currentUser?.screenname!
        
        if let profileImageURL = User.currentUser?.profileUrl {
            profileImageView.setImageWith(profileImageURL)
        } else {
            profileImageView.image = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSendTweetButton(_ sender: AnyObject) {
        let params = [
            "status" : tweetTextView.text!
        ]
        TwitterClient.sharedInstance?.sendTweet(paramaters: params as NSDictionary, success: { ()->() in
            print("sent tweet: \(self.tweetTextView.text)")
            self.tweetTextView.text = ""
            }, failure: { (error: Error) in
                print("error sending tweet: \(error)")
        })
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
