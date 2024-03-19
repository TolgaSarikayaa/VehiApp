//
//  DataModelController.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.03.24.
//

import Foundation
import CoreData

class DataModelController : ObservableObject {
    static let shared = DataModelController()
       let container = NSPersistentContainer(name: "DataModel")

       init() {
           container.loadPersistentStores { description, error in
               if let error = error {
                   print(error.localizedDescription)
               }
           }
       }
}
