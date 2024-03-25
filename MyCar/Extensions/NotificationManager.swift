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
        content.title = NSLocalizedString("Maintenance Reminder", comment: "Title for maintenance reminder notification")
        content.body = String(format: NSLocalizedString("It's time for the next maintenance of your %@ %@.", comment: "Body for maintenance reminder notification"), newCar.brand, newCar.model)
        content.sound = .default
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: newCar.nextMaintenanceDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let identifier = "maintenance \(newCar.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func insuranceNotification(for newCar: NewCarModel) {
        
        let content = UNMutableNotificationContent()
        content.title =  NSLocalizedString("Inspection Reminder", comment: "Title for insurance reminder notification")
        content.body = String(format: NSLocalizedString("It's time for the next inspection of your %@ %@.", comment: "Body for inspection reminder notification"), newCar.brand, newCar.model)
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: newCar.insuranceExpirationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let identifier = "inspection \(newCar.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(for newCar: NewCarModel, type: NotificationType) {
        let identifier: String
        switch type {
        case .maintenance:
            identifier = "maintenance \(newCar.id.uuidString)"
        case .inspection:
            identifier = "inspection \(newCar.id.uuidString)"
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    enum NotificationType {
        case maintenance, inspection
    }
    
    
    func updateNotification(for newCar: NewCarModel) {
        cancelNotification(for: newCar, type: .maintenance)
        maintenanceDateNotification(for: newCar)
        cancelNotification(for: newCar, type: .inspection)
        insuranceNotification(for: newCar)
    }
}
    
func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
           // print("Notification permissions accepted.")
        } else  {
            
        }
    }
}





