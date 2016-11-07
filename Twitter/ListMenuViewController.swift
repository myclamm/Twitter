//
//  ListMenuViewController.swift
//  Twitter
//
//  Created by Mike Lam on 11/6/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class ListMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var hamburgerViewController: HamburgerViewController!
    var viewControllers:  [UIViewController] = []
    var menuKey = ["Timeline","Mentions","Profile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let TweetsViewNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsViewNavigationController")
        let MentionsViewNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        
        viewControllers.append(TweetsViewNavigationController)
        viewControllers.append(MentionsViewNavigationController)
        
        // Initialize hamburgerView with Tweets View
        hamburgerViewController.contentViewController = TweetsViewNavigationController
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

extension ListMenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenuViewCell", for: indexPath) as! MenuViewCell
        cell.titleLabel.text = menuKey[indexPath.row]
        
        return cell
        
    }
}

extension ListMenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
}
