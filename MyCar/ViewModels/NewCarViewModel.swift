//
//  NewCarViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.03.24.
//

import Foundation
import CoreData

class NewCarViewModel : ObservableObject {
    
   var carModelController = NewCarModelController()
    
    func saveCar(context:NSManagedObjectContext,carModel: SelectCarModel) -> NewCarModel {
        let newCar = NewCarModel(brand: carModel.selectedBrand, model: carModel.selectedModel, fuelType: carModel.selectedFuelType, mileage: Int(carModel.mileage) ?? 0, releaseDate: carModel.selectedReleaseDate, nextMaintenanceDate: carModel.selectedNextServiceDate, lastMaintenanceDate: carModel.selectedLastServiceDate, insuranceExpirationDate: carModel.selectedInsuranceExpirationDate, licensePlate: carModel.selectedLicensePlate, image: carModel.selectedImage)
        
        carModelController.addCar(car: newCar, context: context)
        
        return newCar
    }
    
}
