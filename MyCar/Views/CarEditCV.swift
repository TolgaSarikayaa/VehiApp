//
//  CarDetailCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.02.24.
//

import SwiftUI
import SwiftData


struct CarEditCV: View {
   
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @ObservedObject var carEditViewModel = CarEditViewModel()
    @ObservedObject var newCarModel = NewCarModel()
    @State private var fuelTyp : String = ""
    
     var car : CarInformation
    
    var body: some View {
        VStack {
        List {
            Section(header: Text("Car Information")) {
                HStack {
                    TextField("Brand", text: $newCarModel.selectedBrand)
                }
                
                HStack {
                    TextField("Model", text: $newCarModel.selectedModel)
                }
            }
            Section(header: Text("")) {
                HStack {
                    Text("Fuel Type : \(car.fuelType.rawValue)")
                }
                TextField("Mileage", text: $newCarModel.mileage)
            }
            HStack {
                Text("Release date: \(newCarModel.selectedReleaseDate, formatter: DateFormatter.date)")
                    .onTapGesture {
                        newCarModel.isReleaseDatePickerVisible.toggle()
                    }
                Spacer()
                
                Button(action: {
                    newCarModel.isReleaseDatePickerVisible.toggle()
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                })
            }
            if newCarModel.isReleaseDatePickerVisible {
                DatePicker("", selection: $newCarModel.selectedReleaseDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            HStack {
                Text("Last Service: \(newCarModel.selectedLastServiceDate, formatter: DateFormatter.date)")
                    .onTapGesture {
                        newCarModel.isLastServiceDatePickerVisible.toggle()
                    }
                Spacer()
                
                Button(action: {
                    newCarModel.isLastServiceDatePickerVisible.toggle()
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                })
            }
            
            if newCarModel.isLastServiceDatePickerVisible {
                DatePicker("", selection: $newCarModel.selectedLastServiceDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            HStack {
                Text("Next Service: \(newCarModel.selectedNextServiceDate, formatter: DateFormatter.date)")
                    .onTapGesture {
                        newCarModel.isNextServiceDatePickerVisible.toggle()
                    }
                Spacer()
                
                Button(action: {
                    newCarModel.isNextServiceDatePickerVisible.toggle()
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                })
            }
            if newCarModel.isNextServiceDatePickerVisible {
                DatePicker("", selection: $newCarModel.selectedNextServiceDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            
            HStack {
                Text("Insurance Expiration: \(newCarModel.selectedInsuranceExpirationDate, formatter: DateFormatter.date)")
                    .onTapGesture {
                        newCarModel.isInsurancePickerVisible.toggle()
                    }
                Spacer()
                
                Button(action: {
                    newCarModel.isInsurancePickerVisible.toggle()
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                })
            }
            if newCarModel.isInsurancePickerVisible {
                DatePicker("", selection: $newCarModel.selectedInsuranceExpirationDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }

    
        }.onAppear(perform: {
            newCarModel.selectedBrand = car.brand
            newCarModel.selectedModel = car.model
            newCarModel.selectedFuelType = car.fuelType
            newCarModel.mileage = String(car.mileage)
            newCarModel.selectedReleaseDate = car.releaseDate
            newCarModel.selectedLastServiceDate = car.lastMaintenanceDate
            newCarModel.selectedNextServiceDate = car.nextMaintenanceDate
            newCarModel.selectedInsuranceExpirationDate = car.insuranceExpirationDate
        })
            MCButton(title: "Save", background: .blue) {
                carEditViewModel.addEditCar(context: context, newCarModel: newCarModel, car: car)
                dismiss()
                
            } .frame(height: 80)
                .padding()
        }
                
    }

}

/*
 #Preview {
 CarDetailCV()
 }
 */
