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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotifyUserManager.shared.allowUserNotifications()
        NotifyUserManager.shared.delegate()
        return true
    }
    // When app is foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Local notification is received \(notification)")
        // TODO handle it!
    }
}

