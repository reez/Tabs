//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(1800) // 30 mins
        registerForLocalNotifications(application: application)
        
        let vc = AddNodeViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .white
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        
                        if $0.syncedToChain == false {
                            self?.addNotification(syncStatus: $0.syncedToChain)
                        }
                        
                        completionHandler(.newData)
                }
            }
        case .failure(_):
            completionHandler(.failed)
        }
        
    }
    
    func registerForLocalNotifications(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [ .alert]) { [weak center, weak self] (granted, error) in
            guard granted, let center = center, let `self` = self else { return }
            print("registerForLocalNotifications")
        }
    }
    
    func addNotification(syncStatus: Bool) {
        
        let content = UNMutableNotificationContent()
        content.title = "🌩 Node is Not Synced"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
            print("added(request)")
        })
    }
    
}
