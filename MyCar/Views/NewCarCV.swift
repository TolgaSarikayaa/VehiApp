//
//  NewCarCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 16.01.24.
//

import SwiftUI
import SwiftData


struct NewCarCV: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
   
    @ObservedObject var carListViewModel : CarListViewModel
    @ObservedObject var newCarModel = NewCarModel()
    
    init() {
        self.carListViewModel = CarListViewModel(service: LocalService())
    }
    
    private var isFormValid: Bool {
        !newCarModel.mileage.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Select Brand and Model")) {
                    HStack {
                        Picker("Select Brand", selection: $newCarModel.selectedBrandIndex) {
                            ForEach(carListViewModel.carList.indices, id: \.self) { index in
                                Text(carListViewModel.carList[index].brand)
                                
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: newCarModel.selectedBrandIndex) { _ in
                            newCarModel.selectedBrand = carListViewModel.carList[newCarModel.selectedBrandIndex].brand
                        }
                    }
                    
                    HStack {
                        if !carListViewModel.carList.isEmpty {
                            let selectedBrandModels = carListViewModel.carList[newCarModel.selectedBrandIndex].models
                            Picker("Select Model", selection: $newCarModel.selectedModelIndex) {
                                ForEach(selectedBrandModels.indices, id: \.self) { index in
                                    Text(selectedBrandModels[index])
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: newCarModel.selectedModelIndex) { _ in
                                newCarModel.selectedModel = selectedBrandModels[newCarModel.selectedModelIndex]
                            }
                        }
                    }
                }
                
                Section(header: Text("Select your car information")) {
                    HStack {
                        Picker("Fuel type", selection: $newCarModel.selectedFuelType) {
                            ForEach(CarInformation.EngineType.allCases, id: \.self) { fuelType in
                                Text(fuelType.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        TextField("Enter Mileage", text: $newCarModel.mileage)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    }
                    
                    HStack {
                        Text("Release date: \(newCarModel.selectedReleaseDate, formatter: DateFormatter.date)")
                            .onTapGesture {
                                newCarModel.isReleaseDatePickerVisible.toggle()
                            }
                        
                        Spacer()
                        
                        Button(action: {
                            newCarModel.isReleaseDatePickerVisible.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    if newCarModel.isReleaseDatePickerVisible {
                        DatePicker("", selection: $newCarModel.selectedReleaseDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                    
                }
                Section(header: Text("Maintenance information ")) {
                HStack {
                    Text("Last Maintenance: \(newCarModel.selectedLastMaintenanceDate, formatter: DateFormatter.date)")
                        .onTapGesture {
                            newCarModel.isLastMaintenanceDatePickerVisible.toggle()
                        }
                    Spacer()
                    
                    Button(action: {
                        newCarModel.isLastMaintenanceDatePickerVisible.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                    
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
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                    if newCarModel.isNextMaintenanceDatePickerVisible {
                        DatePicker("", selection: $newCarModel.nextMaintenanceDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                }
            }
                
                
            }
            
            .navigationTitle("Add Car")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                       Text("Dismiss")
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveCar()
                        dismiss()
                    } label: {
                        Image(systemName: "plus.app")
                    }.disabled(!isFormValid)

                }
                
            }
          }
       
        .task {
           await carListViewModel.downloadCars()
          
        }
    
       
    }
    
     func saveCar() {
        let carInformation = CarInformation(
                   brand: newCarModel.selectedBrand,
                   model: newCarModel.selectedModel,
                   fuelType: newCarModel.selectedFuelType,
                   mileage: Int(newCarModel.mileage) ?? 0,
                   releaseDate: newCarModel.selectedReleaseDate,
                   nextMaintenanceDate: newCarModel.nextMaintenanceDate,
                   lastMaintenanceDate: newCarModel.selectedLastMaintenanceDate
               )
        
               context.insert(carInformation)
         
                 do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
         }
    
   }





extension DateFormatter {
static var date: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
   }
}


#Preview {
    NewCarCV().modelContainer(for: [CarInformation.self])
}
