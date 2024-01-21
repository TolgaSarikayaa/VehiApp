//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct CarEditCV: View {
    
    @ObservedObject var carInformationListViewModel = CarInformationViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(carInformationListViewModel.carInformationList) { carInformation in
                // Burada carInformation verilerini kullanarak liste öğelerini oluşturabilirsiniz
                  Text("\(carInformation.brand) \(carInformation.model)")
                    Text("Fuel Type: \(carInformation.fuelType.rawValue)")
                                    Text("Mileage: \(carInformation.mileage)")
                                    Text("Release Date: \(carInformation.releaseDate, formatter: DateFormatter.date)")
                                    Text("Last Maintenance Date: \(carInformation.lastMaintenanceDate, formatter: DateFormatter.date)")
                                    Text("Next Maintenance Date: \(carInformation.nextMaintenanceDate, formatter: DateFormatter.date)")
                }
              }
               
            }
            .navigationTitle("My Cars")
            .navigationBarItems(trailing: Button(action: {
                
                    }) {
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                    })
        
            .task {
                        await carInformationListViewModel.downloadCars()
            }
        }
    
    }


#Preview {
    CarEditCV()
    
}
