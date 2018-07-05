//
//  AppDelegate.swift
//  Elite Self
//
//  Created by Администратор on 11/02/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UserNotificationManager.shared.allowUserNotifications()
        return true
    }
}

