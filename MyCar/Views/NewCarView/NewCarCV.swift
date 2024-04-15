//
//  NewCarCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 16.01.24.
//

import SwiftUI
import CoreData
import TipKit


struct NewCarCV: View {
    
    @Environment(\.dismiss) private var dismiss
 
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @StateObject var carModelController = NewCarModelController()
    @State private var showingImagePicker = false
    @State private var showingActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    

    
    @ObservedObject var viewModel = NewCarViewModel()
    @ObservedObject var newCarModel = SelectCarModel()
    @StateObject var carListViewModel: CarListViewModel = CarListViewModel(service: LocalService())
   
    private var isFormValid: Bool {
        !newCarModel.mileage.trimmingCharacters(in: .whitespaces).isEmpty && newCarModel.mileage.count <= 6
    }
 
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Button("Select your car image") {
                        showingActionSheet.toggle()
                    }
                    
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(
                            title: Text("Add a picture"),
                            message: Text("Choose a picture"),
                            buttons: [
                                .default(Text("Camera")) {
                                    self.imageSource = .camera
                                    self.showingImagePicker = true
                                },
                                .default(Text("Photo Library")) {
                                    self.imageSource = .photoLibrary
                                    self.showingImagePicker = true
                                },
                                .cancel()
                            ]
                        )
                    }
                }
                
                if let selectedImage = newCarModel.selectedImage {
                HStack {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
                Section(header: Text("Select Brand and Model")) {
                    HStack {
                        Picker("Select Brand", selection: $newCarModel.selectedBrandIndex) {
                            ForEach(carListViewModel.carList.indices, id: \.self) { index in
                            Text(carListViewModel.carList[index].brand)
                        }
                    }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: newCarModel.selectedBrandIndex) {
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
                        .onChange(of: newCarModel.selectedModelIndex) { 
                        newCarModel.selectedModel = selectedBrandModels[newCarModel.selectedModelIndex]
                        }
                    }
                }
            }
                Section(header: Text("Select your car information")) {
                    HStack {
                        Picker("Fuel type", selection: $newCarModel.selectedFuelType) {
                            ForEach(EngineType.allCases, id: \.self) { fuelType in
                                Text(fuelType.localized)
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
                        TextField("Enter License Plate Number", text: $newCarModel.selectedLicensePlate)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    }
                    HStack {
                        DatePickerView(label: NSLocalizedString("Release date", comment: "Label for release date picker"),
                                       selectedDate: $newCarModel.selectedReleaseDate,
                                       isPickerVisible: $newCarModel.isReleaseDatePickerVisible,
                                       formatter: .date)
                    }
                    
                }
                Section(header: Text("Service information ")) {
                    HStack {
                        DatePickerView(label: NSLocalizedString("Last Service", comment: "Label for last servise date picker"),
                                       selectedDate: $newCarModel.selectedLastServiceDate,
                                       isPickerVisible: $newCarModel.isLastServiceDatePickerVisible,
                                       formatter: .date)
                    }
                    HStack {
                        DatePickerView(label: NSLocalizedString("Next Service", comment: "Label for next servise date picker"),
                                       selectedDate: $newCarModel.selectedNextServiceDate,
                                       isPickerVisible: $newCarModel.isNextServiceDatePickerVisible,
                                       formatter: .date)
                    }
                }
                Section(header: Text("Inspection information ")) {
                    HStack {
                        DatePickerView(label: NSLocalizedString("Inspection date", comment: "Label for Inspection date  picker"),
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
                          let newCar =  viewModel.saveCar(context: managedObjectContext, carModel: newCarModel)
                            NotificationManager.shared.maintenanceDateNotification(for: newCar)
                            NotificationManager.shared.insuranceNotification(for: newCar)
                    
                            dismiss()
                        } label: {
                            Image(systemName: "plus.app")
                        }.disabled(!isFormValid)
                        
                    }
                }
            
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(selectedImage: $newCarModel.selectedImage, sourceType: self.imageSource)
                       }
            
        }.onAppear {
            Task {
                await carListViewModel.downloadCars()
                await setupInitialCarSelection()
            }
        }
    }
    private func setupInitialCarSelection() async {
        if let firstBrand = carListViewModel.carList.first {
            newCarModel.selectedBrandIndex = 0
            newCarModel.selectedBrand = firstBrand.brand

            if let firstModel = firstBrand.models.first {
                newCarModel.selectedModelIndex = 0
                newCarModel.selectedModel = firstModel
            }
        }
    }
    
}


extension DateFormatter {
    static var date: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}

#Preview {
    NewCarCV()
}
