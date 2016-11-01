//
//  TweetViewCell.swift
//  Twitter
//
//  Created by Mike Lam on 10/31/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            print("---->profileImageUrl: \(tweet.profileImageURL)")
            if let profileImageURL = tweet.profileImageURL {
                print("type: \(type(of:profileImageURL))")
                profileImageView.setImageWith(profileImageURL)
            } else {
                profileImageView.image = nil
            }
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.username
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
