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
                Section(header: Text("Car Information")) {
                    Text("\(carEditViewModel.newCarModel.selectedBrand)")
                    Text("\(carEditViewModel.newCarModel.selectedModel)")
                TextField("License", text: $carEditViewModel.newCarModel.selectedLicensePlate)
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
                       }
                   .onAppear {
                       carEditViewModel.prepareData(car: car)
                   }
                   
            MCButton(title: "Save", background: .blue, action: {
                carEditViewModel.addEditCar(context: context, car: car)
                dismiss()
            })
            .frame(height: 80)
            .disabled(!isMileageValid)
        }
    }
}

   


