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
        
        self.tabBar.tintColor = .systemBlue//.mr_blue
        
        let status = StatusViewController()
        status.tabBarItem.title = "Status"
        status.view.backgroundColor = .systemBackground//.white
        status.tabBarItem.image = UIImage(named: "checkmark.circle")
        
        let invoices = InvoicesTableViewController()
        invoices.tabBarItem.title = "Invoices"
        invoices.view.backgroundColor = .systemBackground//.white
        invoices.tabBarItem.image = UIImage(named: "bolt.circle")
        
        let settings = SettingsViewController()
        settings.tabBarItem.title = "Settings"
        settings.view.backgroundColor = .systemBackground//.white
        settings.tabBarItem.image = UIImage(named: "line.horizontal.3.decrease.circle")
        
        let viewControllers = [status, invoices, settings]
        self.viewControllers = viewControllers
        
    }
    
}
