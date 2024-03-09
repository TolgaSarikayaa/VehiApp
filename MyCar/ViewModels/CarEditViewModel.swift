//
//  CarEditViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.02.24.
//

import Foundation
import CoreData

class CarEditViewModel : ObservableObject {
    
    @Published var newCarModel = SelectCarModel()
    
    init(car: NewCarModel) {
        prepareData(car: car)
    }
    
    
    func prepareData(car: NewCarModel) {
            newCarModel.selectedBrand = car.brand
            newCarModel.selectedModel = car.model
            newCarModel.mileage = String(car.mileage)
            newCarModel.selectedReleaseDate = car.releaseDate
            newCarModel.selectedLastServiceDate = car.lastMaintenanceDate
            newCarModel.selectedNextServiceDate = car.nextMaintenanceDate
            newCarModel.selectedInsuranceExpirationDate = car.insuranceExpirationDate
            newCarModel.selectedLicensePlate = car.licensePlate
        }
    
    func addEditCar(context: NSManagedObjectContext, car: NewCarModel) {
        let fetchRequest: NSFetchRequest<NewCarEntity> = NewCarEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", car.id as CVarArg)

        let carEntity: NewCarEntity
        do {
            let results = try context.fetch(fetchRequest)

            if let existingCar = results.first {
                carEntity = existingCar
            } else {
                carEntity = NewCarEntity(context: context)
                carEntity.id = car.id
            }

            // Verileri `newCarModel`'den `NewCarEntity`'ye aktarın
            carEntity.brand = newCarModel.selectedBrand
            carEntity.model = newCarModel.selectedModel
            carEntity.licensePlate = newCarModel.selectedLicensePlate
            carEntity.mileage = Int32(newCarModel.mileage) ?? 0
            carEntity.fuelType = car.fuelType.rawValue
            carEntity.releaseDate = newCarModel.selectedReleaseDate
            carEntity.lastMaintenanceDate = newCarModel.selectedLastServiceDate
            carEntity.nextMaintenanceDate = newCarModel.selectedNextServiceDate
            carEntity.insuranceExpirationDate = newCarModel.selectedInsuranceExpirationDate

            // Context üzerindeki değişiklikleri kaydedin
            try context.save()
        } catch {
            // Hata yönetimi
            print("Failed to save or find car: \(error)")
        }
    }
}
