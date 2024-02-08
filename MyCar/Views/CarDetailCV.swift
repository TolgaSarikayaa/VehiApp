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
    
     var car : CarInformation
    
    var body: some View {
          HStack {
                    // Sol taraftaki bilgiler için VStack
                    VStack(alignment: .leading) {
                        // Bilgileri burada göster
                        Text(newCarModel.selectedBrand)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(newCarModel.selectedModel)
                            .font(.title2)
                            .padding(.bottom, 20) // Altta biraz boşluk bırak
                        HStack {
                            Image(systemName: "fuelpump.circle.fill")
                                .font(.system(size: 36))
                            Text("\(car.fuelType.rawValue) Fuel")
                                .font(.system(size: 20))
                            // VStack içinde Spacer, yazıları yukarı itecek
                        }
                        
                        .padding(.bottom, 25)
                        
                        HStack {
                            Image(systemName: "car.rear.road.lane.dashed")
                                .font(.system(size: 33))
                            Text("\(newCarModel.mileage) KM")
                                .font(.system(size: 20))
                                
                        }
                        
                        .padding(.bottom, 25)
                        
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .font(.system(size: 36))
                            Text("Release date \(newCarModel.selectedReleaseDate.onlyDateFormatted())")
                                .font(.system(size: 16))
                        }
                        .padding(.bottom, 25)
                        
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .font(.system(size: 36))
                            Text("Next Service \(newCarModel.selectedNextServiceDate.onlyDateFormatted())")
                                .font(.system(size: 16))
                        }
                        .padding(.bottom, 25)
                        
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .font(.system(size: 36))
                            Text("Insurance Expiration \(newCarModel.selectedInsuranceExpirationDate.onlyDateFormatted())")
                                .font(.system(size: 16))
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)

                    Spacer()
            
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
                    newCarModel.selectedNextServiceDate = car.nextMaintenanceDate
                    newCarModel.selectedInsuranceExpirationDate = car.insuranceExpirationDate
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
