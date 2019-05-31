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
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(1800)
//        UIApplication.shared.setMinimumBackgroundFetchInterval(60)
//        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
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
    
    func registerForLocalNotifications(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [ .alert]) { [weak center, weak self] (granted, error) in
            guard granted, let center = center, let `self` = self else { return }
            print("registerForLocalNotifications")
        }
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                    
                        print("s2c: \($0.syncedToChain)")

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
    
    func addNotification(syncStatus: Bool) {
        
        let content = UNMutableNotificationContent()
        content.title = "Synced: \(syncStatus)"
        //        content.badge = 1
        //        content.categoryIdentifier = "New Category Id"
        //        content.userInfo = [
        //            "title": "Title",
        //            "id": "ID"
        //        ]
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
            print("added(request)")
        })
    }
    

}
