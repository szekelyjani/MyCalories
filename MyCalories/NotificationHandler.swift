//
//  NotificationHandler.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 09. 17..
//

import Foundation
import NotificationCenter

class ChallangeNotification {
    static let challangeInstance = ChallangeNotification()
    
    func requestAuthorization(action: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                action()
            }
        }
    }
    
    func setNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Start your daily challange now!"
        content.sound = UNNotificationSound.defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
