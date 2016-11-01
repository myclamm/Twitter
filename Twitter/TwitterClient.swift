//
//  TwitterClient.swift
//  Twitter
//
//  Created by Mike Lam on 10/30/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "5VaXI5AIOKmsbRbQacHLytDFR", consumerSecret: "vzJzkvswaJY8gf7iMyiWRNShKLVLOByEFNbvnCal0b4N35DIw5")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error)->())?
    
    
    func login (success: @escaping ()->(), failure: @escaping (Error)->()) {
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"twitterapp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            self.loginSuccess = success
            self.loginFailure = failure
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }, failure: { (error: Error?) -> Void in
                self.loginFailure?(error!)
        })
    }
    
    func logout () {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
        
    }
    
    func handleOpenUrl(url: URL) {
        if(( url.query!.range(of:"oauth_token")) == nil){
            print("User cancelled Oauth")
            return
        }
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            print("I got the access token! \(accessToken)")
            
            self.currentAccount(success: {(user: User)->() in
                
                User.currentUser = user
                self.loginSuccess?()
                }, failure: {(error: Error)->() in
                self.loginFailure?(error)
            })
            
            
            }, failure: { (error: Error?) in
                self.loginFailure!(error!)
        })
    }
    
    func homeTimeLine (success: @escaping ([Tweet])->(), failure: @escaping (Error)->()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?)->Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
            }, failure: {(task:URLSessionDataTask?, error: Error)-> Void in
                failure(error)
        })
    }
    
    // Give this one optional succes and failure callbacks
    func currentAccount(success: @escaping (User)->(), failure: @escaping (Error)->()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
    }
    
    func sendTweet(paramaters: NSDictionary, success: @escaping ()->(), failure: @escaping (Error)->()) {

        post("1.1/statuses/update.json", parameters: paramaters, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) in
            success()
        }) { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        }
    }
    
}
