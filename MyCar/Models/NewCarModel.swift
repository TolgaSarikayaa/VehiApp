//
//  NewCarModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.03.24.
//

import Foundation
import CoreData

class NewCarModel : Identifiable {
    var id = UUID()
    var brand: String
    var model: String
    var fuelType: EngineType
    var mileage: Int
    var releaseDate: Date
    var nextMaintenanceDate = Date()
    var lastMaintenanceDate = Date()
    var insuranceExpirationDate = Date()
    var licensePlate: String
   

   
   init(id: UUID = UUID(), brand: String, model: String, fuelType: EngineType, mileage: Int, releaseDate: Date, nextMaintenanceDate: Date, lastMaintenanceDate: Date,insuranceExpirationDate: Date, licensePlate: String) {
       self.id = id
       self.brand = brand
       self.model = model
       self.fuelType = fuelType
       self.mileage = mileage
       self.releaseDate = releaseDate
       self.nextMaintenanceDate = nextMaintenanceDate
       self.lastMaintenanceDate = lastMaintenanceDate
       self.insuranceExpirationDate = insuranceExpirationDate
       self.licensePlate = licensePlate
   }
    
 
}

enum EngineType: String, CaseIterable , Codable {
    case diesel = "Dizel"
    case benzin = "Benzin"
    case electric = "Electric"
}
