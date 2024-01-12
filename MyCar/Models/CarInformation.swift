//
//  CarInformation.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 12.01.24.
//

import Foundation

struct CarInformation: Codable {
    struct MaintenanceInfo: Codable {
        var lastMaintenanceDate: Date
        var lastMaintenanceMileage: Int
        var previousMaintenanceDate: Date
        var previousMaintenanceMileage: Int
        var nextMaintenanceDate: Date
        var estimatedNextMaintenanceMileage: Int
        var repairsAndReplacements: String
        var serviceHour: String?
    }

    struct ExpenseInfo: Codable {
        var fuelConsumption: Double?
        var tireChangeDate: Date
        var tireChangeMileage: Int
        var insuranceInfo: String
        var taxInfo: String
        var kaskoInfo: String
        var otherExpenses: String
    }

    struct DailyUsageInfo: Codable {
        var dailyDistance: Double
        var dailyTimeSpent: String
        var averageSpeed: Double
    }

    struct NoteAndDocumentInfo: Codable {
        var importantDates: String
        var carNotes: String
        var documents: [String]
    }

    struct ReminderInfo: Codable {
        var upcomingMaintenanceReminders: String
        var insuranceRenewalReminders: String
    }

    var brand: String
    var model: String
    var year: Int
    var color: String
    var chassisNumber: String
    var plateNumber: String
    var engineType: String
    var fuelType: String
    var mileage: Int
    var releaseDate: Date

    var maintenanceInfo: MaintenanceInfo
    var expenseInfo: ExpenseInfo
    var dailyUsageInfo: DailyUsageInfo
    var noteAndDocumentInfo: NoteAndDocumentInfo
    var reminderInfo: ReminderInfo
}
