//
//  CarEditViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.02.24.
//

import Foundation
import SwiftData

class CarEditViewModel : ObservableObject {
    
    func addEditCar(context: ModelContext, newCarModel: NewCarModel, car: CarInformation) {
        if let mileageInt = Int(newCarModel.mileage) {
            car.mileage = mileageInt
        }
        car.brand = newCarModel.selectedBrand
        car.model = newCarModel.selectedModel
        car.fuelType = newCarModel.selectedFuelType
        car.releaseDate = newCarModel.selectedReleaseDate
        car.lastMaintenanceDate = newCarModel.selectedLastServiceDate
        car.nextMaintenanceDate = newCarModel.selectedNextServiceDate
        car.insuranceExpirationDate = newCarModel.selectedInsuranceExpirationDate
        car.licensePlate = newCarModel.selectedLicensePlate
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func prepareData(newCarModel: NewCarModel, car: CarInformation) {
        newCarModel.selectedBrand = car.brand
        newCarModel.selectedModel = car.model
        newCarModel.selectedFuelType = car.fuelType
        newCarModel.mileage = String(car.mileage)
        newCarModel.selectedReleaseDate = car.releaseDate
        newCarModel.selectedLastServiceDate = car.lastMaintenanceDate
        newCarModel.selectedNextServiceDate = car.nextMaintenanceDate
        newCarModel.selectedInsuranceExpirationDate = car.insuranceExpirationDate
        newCarModel.selectedLicensePlate = car.licensePlate
    }
}
