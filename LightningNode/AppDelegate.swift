//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationIdentifier = Reusing<NodeCollectionViewController>().identifier()
        let storyboard = UIStoryboard(name: navigationIdentifier, bundle: Bundle(for: NodeCollectionViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: navigationIdentifier)
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

