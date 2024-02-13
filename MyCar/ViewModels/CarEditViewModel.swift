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
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
