//
//  CarInformation.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 12.01.24.
//

import Foundation
import SwiftData

@Model
class CarInformation: Identifiable {
    var id = UUID()
    var brand: String
    var model: String
    var fuelType: EngineType
    var mileage: Int
    var releaseDate: Date
    var nextMaintenanceDate: Date
    var lastMaintenanceDate: Date
    
    enum EngineType: String, CaseIterable , Codable {
        case diesel = "Dizel"
        case benzin = "Benzin"
        case electric = "Electric"
    }
    
    init(id: UUID = UUID(), brand: String, model: String, fuelType: EngineType, mileage: Int, releaseDate: Date, nextMaintenanceDate: Date, lastMaintenanceDate: Date) {
        self.id = id
        self.brand = brand
        self.model = model
        self.fuelType = fuelType
        self.mileage = mileage
        self.releaseDate = releaseDate
        self.nextMaintenanceDate = nextMaintenanceDate
        self.lastMaintenanceDate = lastMaintenanceDate
    }
    
}
