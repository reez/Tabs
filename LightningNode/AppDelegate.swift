//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import UserNotifications
import BackgroundTasks
import SwiftUI

fileprivate let backgroundTaskIdentifier = "com.matthewramsden.lightningnode.refresh"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        registerForLocalNotifications(application: application)
        
        let swiftUIView = AddNodeUIView()//SettingsViewController()
        let vc = UIHostingController(rootView: swiftUIView)

//        let vc = AddNodeViewController()
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .systemBackground
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
                
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: nil) { (task) in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        return true
    }
    
    func registerForLocalNotifications(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [ .alert]) { [weak center, weak self] (granted, error) in
            guard granted, let _ = center, let _ = self else { return }
            //print("registerForLocalNotifications")
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 30 * 60) // Fetch no earlier than 30 minutes from now
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
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
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        
                        if $0.syncedToChain == false {
                            self?.addNotification(syncStatus: $0.syncedToChain)
                        }
                        
                        task.setTaskCompleted(success: true)
                        
                }
            }
        case .failure(_):
            print("failed")
            task.setTaskCompleted(success: false)
        }
        
    }
    
}
