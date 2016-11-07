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
    var hamburgerViewController: HamburgerViewController!
    
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
            //self.performSegue(withIdentifier: "hamburgerSegue", sender: nil)
            //self.performSegue(withIdentifier: "loginSegue", sender: nil)
            let storyboard = UIStoryboard(name:"Main",bundle:nil)
            
            let hamburgerViewController = storyboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
            let listMenuViewController = storyboard.instantiateViewController(withIdentifier: "ListMenuViewController") as! ListMenuViewController
            
            listMenuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.listMenuViewController = listMenuViewController
            
            self.present(hamburgerViewController, animated: true)
            
            }, failure: { (error: Error)->Void in
            print("error: \(error.localizedDescription)")
        })
        
    }

}

