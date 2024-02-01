//
//  CarDetailCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.02.24.
//

import SwiftUI


struct CarDetailCV: View {
   
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    
    @ObservedObject var newCarModel = NewCarModel()
    @State private var fuelTyp : String = ""
    
    let car : CarInformation
    
    var body: some View {
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
                   TextField("Fuel type", text: $fuelTyp)
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
        }.onAppear(perform: {
            newCarModel.selectedBrand = car.brand
            newCarModel.selectedModel = car.model
        })
        
    }
    
    
}

/*
 #Preview {
 CarDetailCV()
 }
 */
