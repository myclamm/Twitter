//
//  ViewController.swift
//  Twitter
//
//  Created by Mike Lam on 10/30/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.login(success: { ()->() in
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
            }, failure: { (error: Error)->Void in
            print("error: \(error.localizedDescription)")
        })
        
    }

}

