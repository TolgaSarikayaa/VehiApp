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
        
        scheduleAdvanceNotification(for: newCar, date: newCar.nextMaintenanceDate, identifier: "advanceMaintenance")
        
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
        
        scheduleAdvanceNotification(for: newCar, date: newCar.insuranceExpirationDate, identifier: "advanceInspection")
    }
    
    func carWashReminderNotification(for newCar: NewCarModel) {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Car Wash Reminder", comment: "Title for car wash reminder notification")
        content.body = String(format: NSLocalizedString("It's time to wash your %@ %@.", comment: "Body for car wash reminder notification"), newCar.brand, newCar.model)
        content.sound = .default
        
   
        var dateComponents = DateComponents()
        dateComponents.day = 4
        dateComponents.hour = 12

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let identifier = "carWash \(newCar.id.uuidString)"
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
        case .carWash:
            identifier = "carWash \(newCar.id.uuidString)"
        
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    enum NotificationType {
        case maintenance, inspection, carWash
    }
    
    
    func updateNotification(for newCar: NewCarModel) {
        cancelNotification(for: newCar, type: .maintenance)
        maintenanceDateNotification(for: newCar)
        cancelNotification(for: newCar, type: .inspection)
        insuranceNotification(for: newCar)
        carWashReminderNotification(for: newCar)
    }
    
    func scheduleAdvanceNotification(for newCar: NewCarModel, date: Date, identifier: String) {
        let advanceDate = Calendar.current.date(byAdding: .day, value: -14, to: date) ?? date
        
        let content = UNMutableNotificationContent()
        content.title = identifier.contains("Maintenance") ? NSLocalizedString("Upcoming Maintenance", comment: "Title for upcoming maintenance reminder notification") : NSLocalizedString("Upcoming Inspection", comment: "Title for upcoming inspection reminder notification")
        content.body = String(format: identifier.contains("Maintenance") ?  NSLocalizedString("The next maintenance for your %@ %@ is in two weeks.", comment: "Body for upcoming maintenance reminder notification") : NSLocalizedString("The next inspection for your %@ %@ is in two weeks.", comment: "Body for upcoming inspection reminder notification"), newCar.brand, newCar.model)
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: advanceDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(identifier) \(newCar.id.uuidString)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
}
    
func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
        
        } else  {
            
        }
    }
}





