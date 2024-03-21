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
    
    func maintenanceDateNotification(for newCar: NewCarModel) {
        
        let content = UNMutableNotificationContent()
        content.title = "Maintenance Reminder"
        content.body = "It's time for the next maintenance of your \(newCar.brand) \(newCar.model)."
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: newCar.nextMaintenanceDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let identifier = "maintenance \(newCar.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        print("Scheduling maintenance notification for \(newCar.brand) \(newCar.model) on \(newCar.nextMaintenanceDate)")
        
    }
    
    func insuranceNotification(for newCar: NewCarModel) {
        
        let content = UNMutableNotificationContent()
        content.title = "Insurance Reminder"
        content.body = "It's time for the next insurance of your \(newCar.brand) \(newCar.model)."
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: newCar.insuranceExpirationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let identifier = "insurance \(newCar.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(for newCar: NewCarModel, type: NotificationType) {
        let identifier: String
        switch type {
        case .maintenance:
            identifier = "maintenance \(newCar.id.uuidString)"
        case .insurance:
            identifier = "insurance \(newCar.id.uuidString)"
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    enum NotificationType {
        case maintenance, insurance
    }
    
    
    func updateNotification(for newCar: NewCarModel) {
        cancelNotification(for: newCar, type: .maintenance)
        maintenanceDateNotification(for: newCar)
        cancelNotification(for: newCar, type: .insurance)
        insuranceNotification(for: newCar)
    }
}
    
func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
           // print("Notification permissions accepted.")
        } else if let error = error {
            //print("Notification permissions denied: \(error.localizedDescription)")
        }
    }
}





