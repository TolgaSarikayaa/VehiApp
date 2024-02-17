//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI
import SwiftData

struct CarListView: View {
    @State private var searchText = ""
    @State private var isNavigationActive = false
    let cars : [CarInformation]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                if searchResult.isEmpty {
                } else {
                    ForEach(searchResult) { car in
                        Section {
                            NavigationLink(value: car) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Image("car")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 200)
                                        .cornerRadius(10)
                                    Text("\(car.brand)")
                                        .font(.headline)
                                    Text("\(car.model)")
                                    
                                }
                            }
                            
                            .padding()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                        
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let car = cars[index]
                            context.delete(car)
                            
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    })
                }
            }.navigationDestination(for: CarInformation.self) { car in
                CarDetailCV(car: car)
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("My Cars")
            .navigationBarItems(trailing: Button(action: {
                isNavigationActive.toggle()
            }) {
                Image(systemName: "car.fill")
                    .foregroundColor(.blue)
            })
            .sheet(isPresented: $isNavigationActive, content: {
                NewCarCV()
            })
        }.searchable(text: $searchText)
    }
    
    var searchResult : [CarInformation] {
        if searchText.isEmpty {
            return cars
        } else {
            return cars.filter { car in
                car.model.lowercased().contains(searchText.lowercased()) ||
                car.brand.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

/*
#Preview {
    CarEditView(cars: [CarInformation(brand: "Test", model: "", fuelType: CarInformation.EngineType.benzin, mileage: 11, releaseDate: Date(), nextMaintenanceDate: Date(), lastMaintenanceDate: Date())]).modelContainer(for: [CarInformation.self])
}
*/
