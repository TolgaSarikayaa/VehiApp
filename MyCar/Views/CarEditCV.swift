//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct CarEditCV: View {
    
    @ObservedObject var carInformationListViewModel = CarInformationViewModel()
    
    @State private var isNavigationActive = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(carInformationListViewModel.carInformationList) { carInformation in
                    VStack(alignment: .leading, spacing: 5) {
                        Image("car2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                        Text("\(carInformation.brand) \(carInformation.model)")
                            .font(.headline)
                            .foregroundStyle(.white)
                        //Text("Fuel Type: \(carInformation.fuelType.rawValue)")
                        //Text("Mileage: \(carInformation.mileage)")
                        //Text("Release Date: \(carInformation.releaseDate, formatter: DateFormatter.date)")
                        //Text("Last Maintenance Date: \(carInformation.lastMaintenanceDate, formatter: DateFormatter.date)")
                        //Text("Next Maintenance Date: \(carInformation.nextMaintenanceDate, formatter: DateFormatter.date)")
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
              
              }
               
            }
        
            .navigationTitle("My Cars")
            .navigationBarItems(trailing: Button(action: {
                isNavigationActive.toggle()
                    }) {
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                    })
        
                    NavigationLink(
                       destination: NewCarCV(),
                       isActive: $isNavigationActive,
                       label: {
                           EmptyView()
                       })
        
            .task {
                 //await carInformationListViewModel.downloadCars()
            }
           
        }
    
    }


#Preview {
    CarEditCV()
    
}
