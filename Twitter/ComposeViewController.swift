//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Mike Lam on 10/31/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetTextView: UITextView!
    var replyToId : Int?
    var replyToUser: String?
    var delegate: TweetsViewController?
    
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
        
        if(replyToUser != nil){
            tweetTextView.text = "@\(replyToUser!)"
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
        var params = [
            "status" : tweetTextView.text!
        ]
        if(replyToId != nil){
            params["in_reply_to_status_id"] = String(describing: replyToId)
        }
        TwitterClient.sharedInstance?.sendTweet(paramaters: params as NSDictionary, success: { ()->() in
            print("sent tweet: \(self.tweetTextView.text)")
            self.tweetTextView.text = ""
            self.replyToId = nil
            self.replyToUser = nil
            // Update tweetsviewcontroller list of tweets
            self.delegate!.updateTweets()
            // Navigate back to home
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "TweetsViewController") as! TweetsViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
            }, failure: { (error: Error) in
                print("error sending tweet: \(error)")
        })
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // Capture text from compose box
        var text = textView.text!
        var charCount = text.characters.count
        // If charCount>=140 freeze textview
        if (charCount > 140) {
            text.remove(at: text.index(before: text.endIndex))
            textView.text = text
            charCount -= 1
        }
        // Update charCount label
        charCountLabel.text = ("\(charCount)/140")
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
