//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct CarEditCV: View {
    
    @ObservedObject var carListViewModel: CarListViewModel
    
    init(carListViewModel: CarListViewModel) {
            self.carListViewModel = carListViewModel
        }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(carListViewModel.newcarList) { car in
                    VStack(alignment: .leading) {
                        Text("\(car.brand) \(car.model)")
                            .font(.headline)
                        Text("Fuel Type: \(car.fuelType.rawValue)")
                        Text("Mileage: \(car.mileage)")
                     Text("Release Date: \(car.releaseDate, formatter: DateFormatter.date)")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
               
            }
            .navigationTitle("My Cars")
            .navigationBarItems(trailing: Button(action: {
                
                    }) {
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                    })
        }
    }
}

#Preview {
    CarEditCV(carListViewModel: CarListViewModel(service: LocalService()))
    
}
