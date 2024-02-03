//
//  CarInformationViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 19.01.24.
//

import Foundation

class CarInformationViewModel : ObservableObject {
    
    @Published var carInformationList: [CarInformation] = []
        
        func addCar(_ car: CarInformation) {
           
           
        }
        
        func downloadCars() async {
            
        }
}
