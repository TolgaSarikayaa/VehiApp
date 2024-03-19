//
//  CarDetailViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.02.24.
//

import Foundation

class CarDetailViewModel : ObservableObject {
    
   @Published var newCarModel = SelectCarModel()
    
    init(car: NewCarModel) {
          prepareData(car: car)
      }

    func prepareData(car: NewCarModel) {
        newCarModel.selectedBrand = car.brand
        newCarModel.selectedModel = car.model
        newCarModel.selectedFuelType = car.fuelType
        newCarModel.mileage = String(car.mileage)
        newCarModel.selectedReleaseDate = car.releaseDate
        newCarModel.selectedNextServiceDate = car.nextMaintenanceDate
        newCarModel.selectedInsuranceExpirationDate = car.insuranceExpirationDate
    }

}
