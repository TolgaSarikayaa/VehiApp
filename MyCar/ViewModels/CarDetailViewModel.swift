//
//  CarDetailViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.02.24.
//

import Foundation

class CarDetailViewModel : ObservableObject {
    
    func prepareData(newCarModel: NewCarModel, car: CarInformation) {
        newCarModel.selectedBrand = car.brand
        newCarModel.selectedModel = car.model
        newCarModel.selectedFuelType = car.fuelType
        newCarModel.mileage = String(car.mileage)
        newCarModel.selectedReleaseDate = car.releaseDate
        newCarModel.selectedNextServiceDate = car.nextMaintenanceDate
        newCarModel.selectedInsuranceExpirationDate = car.insuranceExpirationDate
    }
}
