//
//  AppDelegate.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 11/02/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = PresenterViewController()
        coordinator = MainCoordinator(presenter: navigationController)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        NotifyUserManager.shared.allowUserNotifications()
        NotifyUserManager.shared.delegate()
        return true
    }
    // When app is foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Local notification is received \(notification)")
    }
}

