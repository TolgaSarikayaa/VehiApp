//
//  NewCarModelController.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.03.24.
//

import Foundation
import CoreData

class NewCarModelController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addCar(car: NewCarModel,context: NSManagedObjectContext) {
       let newCar = NewCarEntity(context: context)
        newCar.id = car.id
        newCar.brand = car.brand
        newCar.model = car.model
        newCar.fuelType = car.fuelType.rawValue
        newCar.mileage = Int32(car.mileage)
        newCar.releaseDate = car.releaseDate
        newCar.nextMaintenanceDate = car.nextMaintenanceDate
        newCar.lastMaintenanceDate = car.lastMaintenanceDate
        newCar.insuranceExpirationDate = car.insuranceExpirationDate
        newCar.licensePlate = car.licensePlate
        
        save(context: context)
    }
    
}
