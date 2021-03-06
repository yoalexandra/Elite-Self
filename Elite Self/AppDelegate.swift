//
//  AppDelegate.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 11/02/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import CoreData
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
		// inject it 
//		if let navVC = window?.rootViewController as?
//			UINavigationController,
//			var initialVC = navVC.viewControllers[0] as?
//			MOCViewControllerType {
//			initialVC.managedObjectContext =
//				persistentContainer.viewContext
//		}
	
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
		persistentContainer.saveContextIfNeeded()
    }
	
	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Elite_Self")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
}

