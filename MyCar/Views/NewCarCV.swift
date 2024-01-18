//
//  NewCarCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 16.01.24.
//

import SwiftUI


struct NewCarCV: View {
    
    @ObservedObject var carListViewModel : CarListViewModel
    @State private var selectedBrandIndex = 0
    @State private var selectedModelIndex = 0
    @State private var isPickerVisible = false
    @State private var isReleaseDatePickerVisible = false
    @State private var isLastMaintenanceDatePickerVisible = false
    @State private var isNextMaintenanceDatePickerVisible = false
    @State private var isBrandPickerVisible = false
    @State private var isModelPickerVisible = false
    @State private var selectedBrand: String = ""
    @State private var selectedModel: String = ""
    @State private var selectedReleaseDate = Date()
    @State private var selectedLastMaintenanceDate = Date()
    @State private var nextMaintenanceDate = Date()
    @State private var mileage: String = ""
    @State private var selectedFuelType: CarInformation.EngineType = .benzin

    
    init() {
        self.carListViewModel = CarListViewModel(service: LocalService())
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Select Brand and Model")) {
                    HStack {
                        Picker("Select Brand", selection: $selectedBrandIndex) {
                            ForEach(carListViewModel.carList.indices, id: \.self) { index in
                                Text(carListViewModel.carList[index].brand)
                                
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedBrandIndex) { _ in
                            selectedBrand = carListViewModel.carList[selectedBrandIndex].brand
                        }
                    }
                    
                    HStack {
                        if !carListViewModel.carList.isEmpty {
                            let selectedBrandModels = carListViewModel.carList[selectedBrandIndex].models
                            Picker("Select Model", selection: $selectedModelIndex) {
                                ForEach(selectedBrandModels.indices, id: \.self) { index in
                                    Text(selectedBrandModels[index])
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: selectedModelIndex) { _ in
                                selectedModel = selectedBrandModels[selectedModelIndex]
                            }
                        }
                    }
                }
                
                Section(header: Text("Select your car information")) {
                    HStack {
                        Picker("Fuel type", selection: $selectedFuelType) {
                            ForEach(CarInformation.EngineType.allCases, id: \.self) { fuelType in
                                Text(fuelType.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        TextField("Enter Milage", text: $mileage)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    }
                    
                    HStack {
                        Text("Release date: \(selectedReleaseDate, formatter: DateFormatter.date)")
                            .onTapGesture {
                                isReleaseDatePickerVisible.toggle()
                            }
                        
                        Spacer()
                        
                        Button(action: {
                            isReleaseDatePickerVisible.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    if isReleaseDatePickerVisible {
                        DatePicker("", selection: $selectedReleaseDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                    
                }
                Section(header: Text("Maintenance information ")) {
                HStack {
                    Text("Last Maintenance: \(selectedLastMaintenanceDate, formatter: DateFormatter.date)")
                        .onTapGesture {
                            isLastMaintenanceDatePickerVisible.toggle()
                        }
                    Spacer()
                    
                    Button(action: {
                        isLastMaintenanceDatePickerVisible.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                    
                }
                    if isLastMaintenanceDatePickerVisible {
                        DatePicker("", selection: $selectedLastMaintenanceDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                }
                    
                    HStack {
                        Text("Next Maintenance: \(nextMaintenanceDate, formatter: DateFormatter.date)")
                            .onTapGesture {
                                isNextMaintenanceDatePickerVisible.toggle()
                            }
                        Spacer()
                        
                        Button(action: {
                            isNextMaintenanceDatePickerVisible.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                    if isNextMaintenanceDatePickerVisible {
                        DatePicker("", selection: $nextMaintenanceDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                }
            }
                
            }
            .navigationTitle("Add Car")
            .navigationBarItems(trailing: Button(action: {
                saveCar()
                NavigationLink(destination: CarEditCV(carListViewModel: carListViewModel)) {
                    
                }
             
                    }) {
                        Image(systemName: "plus.app")
                            .foregroundColor(.blue)
                    })
            
        }
       
        .task {
            await carListViewModel.downloadCars()
        }
        .navigationTitle("Add New Car")
       
    }
    
    func saveCar() {
      let carInformation = CarInformation(brand: selectedBrand, model: selectedModel, fuelType: selectedFuelType, mileage: Int(mileage) ?? 0, releaseDate: selectedReleaseDate, nextMaintenanceDate: nextMaintenanceDate, lastMaintenanceDate: selectedLastMaintenanceDate)
        
        carListViewModel.addCar(carInformation: carInformation)
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
    NewCarCV()
}
