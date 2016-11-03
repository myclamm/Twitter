//
//  TwitterButton.swift
//  Twitter
//
//  Created by Mike Lam on 11/2/16.
//  Copyright © 2016 Matchbox. All rights reserved.
//

import UIKit

class TwitterButton: UIButton {
    func animateOnClick() {
        UIView.animate(withDuration: 0.2, animations: {() -> () in
            self.alpha = 1
        }) { (Bool) in
            self.alpha = 0.5
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
