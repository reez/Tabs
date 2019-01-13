//
//  NavigationViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func pushController() {
        // * This is just for testing
        // Current.keychain.delete()
        // * so I can see Add Node screen
        
        switch Current.keychain.load() {
        case .success(_):
            let bundle = Bundle(for: NodeCollectionViewController.self)
            let storyboard = UIStoryboard(name: "NodeCollectionViewController", bundle: bundle)
            let vc = storyboard.instantiateViewController(withIdentifier: "NodeCollectionViewController") as! NodeCollectionViewController
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            print("Successfully got saved data and ready to proceed!")
        case .failure(_):
            let bundle = Bundle(for: AddNodeViewController.self)
            let storyboard = UIStoryboard.init(name: "AddNodeViewController", bundle: bundle)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddNodeViewController") as! AddNodeViewController
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            print("Did not get saved data or make successful request!")
        }
    }
    
}
