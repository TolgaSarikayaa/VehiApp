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
    
    
    @ObservedObject var newCarModel = NewCarModel()
    @State private var fuelTyp : String = ""
    
    let car : CarInformation
    
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
                Text("Last Maintenance: \(newCarModel.selectedLastMaintenanceDate, formatter: DateFormatter.date)")
                    .onTapGesture {
                        newCarModel.isLastMaintenanceDatePickerVisible.toggle()
                    }
                Spacer()
                
                Button(action: {
                    newCarModel.isLastMaintenanceDatePickerVisible.toggle()
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                })
            }
            
            if newCarModel.isLastMaintenanceDatePickerVisible {
                DatePicker("", selection: $newCarModel.selectedLastMaintenanceDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            HStack {
                Text("Next Maintenance: \(newCarModel.nextMaintenanceDate, formatter: DateFormatter.date)")
                    .onTapGesture {
                        newCarModel.isNextMaintenanceDatePickerVisible.toggle()
                    }
                Spacer()
                
                Button(action: {
                    newCarModel.isNextMaintenanceDatePickerVisible.toggle()
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                })
            }
            if newCarModel.isNextMaintenanceDatePickerVisible {
                DatePicker("", selection: $newCarModel.nextMaintenanceDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            
            
            MCButton(title: "Save", background: .blue) {
                
                if let mileageInt = Int(newCarModel.mileage) {
                    car.mileage = mileageInt
                } else {
                    
                    car.brand = newCarModel.selectedBrand
                    car.model = newCarModel.selectedModel
                    car.fuelType = newCarModel.selectedFuelType
                    car.releaseDate = newCarModel.selectedReleaseDate
                    car.lastMaintenanceDate = newCarModel.selectedLastMaintenanceDate
                    car.nextMaintenanceDate = newCarModel.nextMaintenanceDate
                }
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                dismiss()
                
            }
            
            
        }.onAppear(perform: {
            newCarModel.selectedBrand = car.brand
            newCarModel.selectedModel = car.model
            newCarModel.selectedFuelType = car.fuelType
            newCarModel.mileage = String(car.mileage)
            newCarModel.selectedReleaseDate = car.releaseDate
            newCarModel.selectedLastMaintenanceDate = car.lastMaintenanceDate
            newCarModel.nextMaintenanceDate = car.nextMaintenanceDate
        })
            
        
    }
        
        
    }
    
    
}

/*
 #Preview {
 CarDetailCV()
 }
 */
