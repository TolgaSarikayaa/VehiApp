//
//  CarListViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import Foundation
 
class CarListViewModel : ObservableObject {

    @Published var carList = [carViewModel]()
    

    
    private var service : NetworkService
    init(service: NetworkService) {
        self.service = service
    }
   
   
    
    func downloadCars() async {
        let resource = Constanst.Paths.baseUrl
        
        do {
            let brand = try await service.download(resource)
            DispatchQueue.main.async {
                self.carList = brand.map(carViewModel.init)
            }
        } catch {
            print(error)
        }
    }
}


struct carViewModel {
   
    let car : CarModel
    
    var brand : String {
        car.brand
    }
    
    var models : [String] {
        car.models
    }
    
}
