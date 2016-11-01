//
//  Tweet.swift
//  Twitter
//
//  Created by Mike Lam on 10/30/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageURL: URL?
    var username: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let user = dictionary["user"] as? NSDictionary
        
        // Set profileImage
        let profileImageString = user?["profile_image_url"] as? String
        if let profileImageString = profileImageString {
            profileImageURL = URL(string:profileImageString)
        }
        
        username = user?["screen_name"] as? String

        
        let timestampString = dictionary["created_at"] as? String
        
        // Because created_at might be nil
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let date = formatter.date(from: timestampString)
            formatter.dateFormat = "MMM d, H:mm a"
            timestamp = formatter.string(from: date!)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
