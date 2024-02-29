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
    @ObservedObject var viewModel = CarInformationViewModel()
    
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
                        TextField("Enter License Plate", text: $newCarModel.selectedLicensePlate)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    }
                    HStack {
                        DatePickerView(label: "Release date",
                                       selectedDate: $newCarModel.selectedReleaseDate,
                                       isPickerVisible: $newCarModel.isReleaseDatePickerVisible,
                                       formatter: .date)
                    }
                    
                }
                Section(header: Text("Service information ")) {
                    HStack {
                        DatePickerView(label: "Last Service",
                                       selectedDate: $newCarModel.selectedLastServiceDate,
                                       isPickerVisible: $newCarModel.isLastServiceDatePickerVisible,
                                       formatter: .date)
                    }
                    HStack {
                        DatePickerView(label: "Next Service",
                                       selectedDate: $newCarModel.selectedNextServiceDate,
                                       isPickerVisible: $newCarModel.isNextServiceDatePickerVisible,
                                       formatter: .date)
                    }
                }
                Section(header: Text("Insurance information ")) {
                    HStack {
                        DatePickerView(label: "Insurance Expiration",
                                       selectedDate: $newCarModel.selectedInsuranceExpirationDate,
                                       isPickerVisible: $newCarModel.isInsurancePickerVisible,
                                       formatter: .date)
                    }
                }
            }.navigationTitle("Add Car")
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
                            viewModel.addCar(context: context, newCarModel: newCarModel)
                            dismiss()
                        } label: {
                            Image(systemName: "plus.app")
                        }.disabled(!isFormValid)
                        
                    }
                }
            
        }.task {
            await carListViewModel.downloadCars()
            
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
