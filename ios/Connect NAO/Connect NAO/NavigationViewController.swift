//
//  NavigationViewController.swift
//  Connect NAO
//
//  Created by Alan Rushforth on 27/05/2015.
//  Copyright (c) 2015 Alan Rushforth. All rights reserved.
//

import Foundation
import UIKit


class NavigationViewController : UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Status bar white font
        //self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.barTintColor = UIColor(red: 0x0/0xFF, green: 0x8A/0xFF, blue: 0xDE/0xFF, alpha: 1)
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}