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
    
    func addCar(car: NewCarModel, context: NSManagedObjectContext) {
        let newCarEntity = NewCarEntity(context: context)
        newCarEntity.id = car.id
        newCarEntity.brand = car.brand
        newCarEntity.model = car.model
        newCarEntity.fuelType = car.fuelType.rawValue
        newCarEntity.mileage = Int32(car.mileage)
        newCarEntity.releaseDate = car.releaseDate
        newCarEntity.nextMaintenanceDate = car.nextMaintenanceDate
        newCarEntity.lastMaintenanceDate = car.lastMaintenanceDate
        newCarEntity.insuranceExpirationDate = car.insuranceExpirationDate
        newCarEntity.licensePlate = car.licensePlate
       

        if let carImage = car.carImage {
            newCarEntity.carImage = carImage.jpegData(compressionQuality: 1.0)
        }
        
        
        if let userImage = car.userImage {
            newCarEntity.userImage = userImage.jpegData(compressionQuality: 1.0)
        }
        
        newCarEntity.user = car.user

        save(context: context)
    }
    
}
