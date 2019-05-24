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
        
        self.tabBar.tintColor = .mr_blue

        let status = StatusViewController()
        status.tabBarItem.title = "Status"
        status.view.backgroundColor = .white
        status.tabBarItem.image = UIImage(named: "StatusTab")
        
        let invoices = InvoicesTableViewController()
        invoices.tabBarItem.title = "Invoices"
        invoices.view.backgroundColor = .white
        invoices.tabBarItem.image = UIImage(named: "InvoicesTab")
        
        let settings = SettingsViewController()
        settings.tabBarItem.title = "Settings"
        settings.view.backgroundColor = .white
        settings.tabBarItem.image = UIImage(named: "SettingsTab")
        
        let viewControllers = [status, invoices, settings]
        self.viewControllers = viewControllers
        
    }

}
