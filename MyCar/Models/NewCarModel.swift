//
//  NewCarModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.03.24.
//

import Foundation
import CoreData
import SwiftUI

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
    var image: UIImage?
   

   
    init(id: UUID = UUID(), brand: String, model: String, fuelType: EngineType, mileage: Int, releaseDate: Date, nextMaintenanceDate: Date, lastMaintenanceDate: Date,insuranceExpirationDate: Date, licensePlate: String, image: UIImage?) {
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
       self.image = image
   }
    
 
}

enum EngineType: String, CaseIterable , Codable {
    case diesel = "Diesel"
    case benzin = "Petrol"
    case electric = "Electric"
    
    var localized: String {
            switch self {
            case .diesel:
                return NSLocalizedString("Diesel", comment: "Fuel type")
            case .benzin:
                return NSLocalizedString("Petrol", comment: "Fuel type")
            case .electric:
                return NSLocalizedString("Electric", comment: "Fuel type")
            }
        }
    }

