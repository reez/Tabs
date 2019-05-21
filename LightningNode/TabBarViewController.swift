//
//  TabBarViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/27/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.isHidden = true
        self.tabBar.tintColor = .mr_blue
//        
//        let statusVC = StatusViewController()
//        statusVC.tabBarItem.title = "Stats"
//        
//        let viewcontrollers = [statusVC]
//        self.viewControllers = viewcontrollers
        
    }

}
