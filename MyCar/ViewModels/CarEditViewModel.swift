//
//  CarEditViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.02.24.
//

import Foundation
import CoreData
import UIKit

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
            newCarModel.selectedImage = car.carImage
            newCarModel.selectedUser = car.user
            newCarModel.selectedUserImage = car.userImage
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
            
            carEntity.brand = newCarModel.selectedBrand
            carEntity.model = newCarModel.selectedModel
            carEntity.licensePlate = newCarModel.selectedLicensePlate
            carEntity.mileage = Int32(newCarModel.mileage) ?? 0
            carEntity.fuelType = car.fuelType.rawValue
            carEntity.releaseDate = newCarModel.selectedReleaseDate
            carEntity.lastMaintenanceDate = newCarModel.selectedLastServiceDate
            carEntity.nextMaintenanceDate = newCarModel.selectedNextServiceDate
            carEntity.insuranceExpirationDate = newCarModel.selectedInsuranceExpirationDate
           
            if let selectedImage = newCarModel.selectedImage {
                carEntity.carImage = selectedImage.jpegData(compressionQuality: 1.0)
            }
            
            if let selectedUserImage = newCarModel.selectedUserImage {
                carEntity.userImage = selectedUserImage.jpegData(compressionQuality: 1.0)
            }
            
            carEntity.user = newCarModel.selectedUser

            try context.save()
            
            
            let updatedCar = NewCarModel(id: car.id,
                                        brand: newCarModel.selectedBrand,
                                        model: newCarModel.selectedModel,
                                        fuelType: newCarModel.selectedFuelType,
                                        mileage: Int(newCarModel.mileage) ?? 0,
                                        releaseDate: car.releaseDate,
                                        nextMaintenanceDate: newCarModel.selectedNextServiceDate,
                                        lastMaintenanceDate: newCarModel.selectedLastServiceDate,
                                        insuranceExpirationDate: newCarModel.selectedInsuranceExpirationDate,
                                         licensePlate: newCarModel.selectedLicensePlate, carImage: newCarModel.selectedImage, user: newCarModel.selectedUser, userImage: newCarModel.selectedUserImage)
            
            NotificationManager.shared.updateNotification(for: updatedCar)
            
            NotificationCenter.default.post(name: NSNotification.Name("CarDataUpdated"), object: nil)
        } catch {
            print("Failed to save or find car: \(error)")
        }
    }
}
