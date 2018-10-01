//
//  NotifyUserManagerr.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 21/05/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import UserNotifications

class NotifyUserManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotifyUserManager()
    //MARK: - property to set user notification content
    let content = UNMutableNotificationContent()
    var contents: [NotificationModel] = []
    // The initial user notification time
    let defhour = 10
    let defmin = 30
    // MARK: - Localizable strings properties
    let notifTitle = NSLocalizedString("This words are powerful", comment: "")
    let notifSubtitle = NSLocalizedString("Some of them better to be repeated", comment: "")
    // MARK: - Register UserNotifications
    func allowUserNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
            if granted {
                print("Notification granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    // Delegation method
    func delegate() {
        UNUserNotificationCenter.current().delegate = self
    }
    // Setting up & schedule user notification content
    func notifyUser() {
        //Parse JSON to UserNotification content
        guard let path = Bundle.main.path(forResource: "quotes", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let jsonDict = json as! Dictionary<String, Array<String>>
            for (_ , value) in jsonDict {
                let localizableValue = NSLocalizedString(value.randomElement()!, comment: "")
                let localizableValue1 = NSLocalizedString(value.randomElement()!, comment: "")
                let localizableValue2 = NSLocalizedString(value.randomElement()!, comment: "")
                let one = NotificationModel(title: notifTitle, subtitle: notifSubtitle, body: localizableValue, id: "affirmation", hour: defhour, min: defmin)
                let two = NotificationModel(title: notifTitle, subtitle: notifSubtitle, body: localizableValue1, id: "affirmation1", hour: defhour + 4, min: defmin)
                let three = NotificationModel(title: notifTitle, subtitle: notifSubtitle, body: localizableValue2, id: "affirmation2", hour: defhour + 8, min: defmin)
                contents.append(one)
                contents.append(two)
                contents.append(three)
            }
        } catch {
            print("Fatal error: \(error.localizedDescription)")
        }
        // Remove all pending notifications
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        for item in contents {
            var date = DateComponents()
            date.calendar = Calendar.current
            date.timeZone = NSTimeZone.system
            date.hour = item.hour
            date.minute = item.min
            content.title = item.title
            content.subtitle = item.subtitle
            content.categoryIdentifier = item.id
            content.body = item.body
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
            
            center.add(request)  { (error) in
                if let errorPerforms = error {
                    print("Fatal error: \(errorPerforms.localizedDescription)")
                } else {
                    print("Success")
                    center.getPendingNotificationRequests { (notifications ) in
                        //print("Count: \(notifications.count)")
                        for item  in notifications {
                            //print(item.content)
                            print("-------------------")
                            guard let trigger = item.trigger as? UNCalendarNotificationTrigger else { continue }
                            print(trigger.nextTriggerDate()!)
                        }
                    }
                }
            }
        }
    }
    
} // End class

