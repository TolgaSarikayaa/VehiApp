//
//  CarInformation.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 12.01.24.
//

import Foundation

struct CarInformation: Codable , Identifiable {
    let id = UUID()
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
    
}
