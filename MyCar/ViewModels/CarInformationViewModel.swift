//
//  CarInformationViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 19.01.24.
//


import Foundation
import SwiftData

class CarInformationViewModel : ObservableObject {
    
    
    func addCar(context: ModelContext, newCarModel: NewCarModel) {
        let carInformation = CarInformation(
            brand: newCarModel.selectedBrand,
            model: newCarModel.selectedModel,
            fuelType: newCarModel.selectedFuelType,
            mileage: Int(newCarModel.mileage) ?? 0,
            releaseDate: newCarModel.selectedReleaseDate,
            nextMaintenanceDate: newCarModel.selectedNextServiceDate,
            lastMaintenanceDate: newCarModel.selectedLastServiceDate,
            insuranceExpirationDate: newCarModel.selectedInsuranceExpirationDate
        )
        
        context.insert(carInformation)
        
        do {
            try context.save()
            NotificationManager.shared.scheduleNotification(for: carInformation)
            print("Araba bilgileri başarıyla kaydedildi ve bildirim planlandı.")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
