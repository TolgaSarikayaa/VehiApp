//
//  GasModelController.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.03.24.
//

import Foundation
import CoreData

class FuelModelController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
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
    
    
    func add(price: String, context: NSManagedObjectContext) {
      let task = FuelEntity(context: context)
        task.id = UUID()
        task.price = price
        task.date = Date()
        
        
        
        save(context: context)
        
    }
   
    
}
