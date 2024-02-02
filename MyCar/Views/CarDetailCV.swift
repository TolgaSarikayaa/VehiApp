//
//  CarDetailTestCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.02.24.
//

import SwiftUI

struct CarDetailCV: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var isNavigationActive = false
    
    
    @ObservedObject var newCarModel = NewCarModel()
    @State private var fuelTyp : String = ""
    
    let car : CarInformation
    
    var body: some View {
        HStack {
                    // Sol taraftaki bilgiler için VStack
                    VStack(alignment: .leading, spacing: 10) {
                        // Bilgileri burada göster
                        Text(newCarModel.selectedBrand)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(newCarModel.selectedModel)
                            .font(.title)
                            .padding(.bottom, 20) // Altta biraz boşluk bırak
                        HStack {
                            Image(systemName: "fuelpump.circle.fill")
                                .font(.system(size: 36))
                            Text("\(car.fuelType.rawValue) Fuel")
                                .font(.system(size: 20))
                            // VStack içinde Spacer, yazıları yukarı itecek
                        }
                        
                        .padding(.bottom, 10)
                        
                        HStack {
                            Image(systemName: "steeringwheel.road.lane.dashed")
                                .font(.system(size: 33))
                            Text("\(newCarModel.mileage) KM")
                                .font(.system(size: 20))
                           
                        }
                        
                        .padding(.bottom, 15)
                        
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .font(.system(size: 36))
                            Text("Next Maintenance \(newCarModel.nextMaintenanceDate.onlyDateFormatted())")
                                .font(.system(size: 20))
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)

                    Spacer() // Sol taraftaki VStack ile sağ taraftaki Image arasında boşluk

                   
                    Image("car3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
                        .padding(.trailing, -55)
                }
              .toolbar {
                  ToolbarItem(placement: .topBarTrailing) {
                      Button(action: {
                          isNavigationActive = true
                      }, label: {
                          Text("Edit")
                      })
                  }
              }.sheet(isPresented: $isNavigationActive, content: {
                  CarEditCV(car: car)
              })
                .onAppear(perform: {
                    // Initialize data here
                    newCarModel.selectedBrand = car.brand
                    newCarModel.selectedModel = car.model
                    newCarModel.selectedFuelType = car.fuelType
                    newCarModel.mileage = String(car.mileage)
                    newCarModel.nextMaintenanceDate = car.nextMaintenanceDate
                })
        
        
            }
    
    
        }

extension Date {
    func onlyDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}

/*
#Preview {
    CarDetailCV( car: CarInformation(brand: "Test", model: "tet2", fuelType: CarInformation.EngineType.benzin, mileage:10))
}
*/
