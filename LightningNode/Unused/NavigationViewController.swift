//
//  NavigationViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

//class NavigationViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        pushController()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
//    private func pushController() {
//        switch Current.keychain.load() {
//        case .success(_):
//            let bundle = Bundle(for: NodeCollectionViewController.self)
//            let nodeIdentifier = Reusing<NodeCollectionViewController>().identifier()
//            let storyboard = UIStoryboard(name: nodeIdentifier, bundle: bundle)
//            let vc = storyboard.instantiateViewController(withIdentifier: nodeIdentifier) as! NodeCollectionViewController
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        case .failure(_):
//            let bundle = Bundle(for: AddNodeViewController.self)
//            let addNodeIdentifier = Reusing<AddNodeViewController>().identifier()
//            let storyboard = UIStoryboard.init(name: addNodeIdentifier, bundle: bundle)
//            let vc = storyboard.instantiateViewController(withIdentifier: addNodeIdentifier) as! AddNodeViewController
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    }
//    
//}
