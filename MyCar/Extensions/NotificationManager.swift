//
//  NotificationManager.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 22.01.24.
//

import Foundation
import UserNotifications


class NotificationManager {
    static let shared = NotificationManager()

    func scheduleNotification(for newCar: NewCarModel) {
        let content = UNMutableNotificationContent()
        content.title = "Maintenance Reminder"
        content.body = "It's time for the next maintenance of your \(newCar.brand) \(newCar.model)."
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: newCar.nextMaintenanceDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let identifier = "car \(newCar.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(for newCar: NewCarModel) {
        let identifier = "car \(newCar.id.uuidString)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        print("Notification for \(newCar.brand) \(newCar.model) with ID \(identifier) has been cancelled.")
    }
}
    
func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Notification permissions accepted.")
        } else if let error = error {
            print("Notification permissions denied: \(error.localizedDescription)")
        }
    }
}





