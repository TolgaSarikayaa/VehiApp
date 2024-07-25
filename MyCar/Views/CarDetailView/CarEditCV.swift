//
//  CarDetailCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.02.24.
//

import SwiftUI
import CoreData


struct CarEditCV: View {
   
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var carEditViewModel : CarEditViewModel
    @ObservedObject var newCarModel = SelectCarModel()
    @State private var fuelTyp : String = ""
    @State private var showingImagePicker = false
    @State private var isUserPickerPresented = false
    
    init(car: NewCarModel) {
           self.car = car
           _carEditViewModel = ObservedObject(wrappedValue: CarEditViewModel(car: car))
       }
    
    var car : NewCarModel
    
    var isMileageValid: Bool {
        return carEditViewModel.newCarModel.mileage.count <= 6
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Change your car image")) {
                    Button("Select image") {
                        showingImagePicker.toggle()
                    }
                }
                
                if let selectedImage = carEditViewModel.newCarModel.selectedImage {
                HStack {
                        Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .clipped()
                    }
                }
                Section(header: Text("Car Information")) {
                    Text("\(carEditViewModel.newCarModel.selectedBrand)")
                    Text("\(carEditViewModel.newCarModel.selectedModel)")
                TextField("License Number", text: $carEditViewModel.newCarModel.selectedLicensePlate)
            }
                Section(header: Text("Details")) {
                    Text("Fuel Type: \(car.fuelType.localized)")
                TextField("Mileage", text: $carEditViewModel.newCarModel.mileage)
                        .keyboardType(.decimalPad)
                DatePicker("Release date", selection: $carEditViewModel.newCarModel.selectedReleaseDate, displayedComponents: .date)
                DatePicker("Last Service", selection: $carEditViewModel.newCarModel.selectedLastServiceDate, displayedComponents: .date)
                DatePicker("Next Service", selection: $carEditViewModel.newCarModel.selectedNextServiceDate, displayedComponents: .date)
                DatePicker("Insurance Expiration", selection: $carEditViewModel.newCarModel.selectedInsuranceExpirationDate, displayedComponents: .date)
                }
                Section(header: Text("Change or uninstall the vehicle's driver")) {
                    Button {
                        isUserPickerPresented = true
                    } label: {
                        HStack {
                            Text(carEditViewModel.newCarModel.selectedUser.isEmpty ? "Add Driver" : carEditViewModel.newCarModel.selectedUser)
                            Spacer()
                            if let userImage = car.userImage {
                                Image(uiImage: userImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                            }
                            
                            if !carEditViewModel.newCarModel.selectedUser.isEmpty {
                                Button {
                                    clearUser()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                carEditViewModel.prepareData(car: car)
            }
                   
            MCButton(title: "Save", background: .blue, action: {
                carEditViewModel.addEditCar(context: context, car: car)
                dismiss()
            })
            
            .sheet(isPresented: $showingImagePicker, content: {
                ImagePicker(selectedImage: $carEditViewModel.newCarModel.selectedImage)
            })
            
            .sheet(isPresented: $isUserPickerPresented, content: {
                AddUserView(user: $carEditViewModel.newCarModel.selectedUser, userImage: $carEditViewModel.newCarModel.selectedUserImage)
            })
            
            .frame(height: 80)
            .disabled(!isMileageValid)
        }
    }
    private func clearUser() {
        carEditViewModel.newCarModel.selectedUser = ""
        carEditViewModel.newCarModel.selectedUserImage = nil
       }
}

   


