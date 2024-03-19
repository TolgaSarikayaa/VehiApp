//
//  NewCarModelController.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.03.24.
//

import Foundation
import CoreData

class NewCarModelController: ObservableObject {
   
    var context: NSPersistentContainer
    
    @Published var newCarEntity: [NewCarEntity] = []
    
    init() {
        context = NSPersistentContainer(name: "DataModel")
        context.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData() {
        let request = NSFetchRequest<NewCarEntity>(entityName: "NewCarEntity")
        do {
            newCarEntity = try context.viewContext.fetch(request)
        } catch(let error) {
            print(error)
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
