//
//  CarListViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.05.24.
//

import CoreData
import SwiftUI
import Combine

/*
class CarListViewModel: ObservableObject {
    @Published var cars: [NewCarEntity] = []

    private var cancellables = Set<AnyCancellable>()

    init(context: NSManagedObjectContext) {
        fetchCars(context: context)
    }

    func fetchCars(context: NSManagedObjectContext) {
        let request: NSFetchRequest<NewCarEntity> = NewCarEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NewCarEntity.brand, ascending: true)]

        context.perform {
            do {
                let fetchedCars = try context.fetch(request)
                DispatchQueue.main.async {
                    self.cars = fetchedCars
                }
            } catch {
                print("Failed to fetch cars: \(error.localizedDescription)")
            }
        }
    }

}
*/
