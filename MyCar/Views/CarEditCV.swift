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
                HStack {
                    TextField("Mileage", text: $newCarModel.mileage)
                }
                HStack {
                    TextField("License", text: $newCarModel.selectedLicensePlate)
                }
            }
            HStack {
             DatePickerView(label: "Release date",
                            selectedDate: $newCarModel.selectedReleaseDate,
                            isPickerVisible: $newCarModel.isReleaseDatePickerVisible,
                            formatter: .date)
            }
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
            HStack {
           DatePickerView(label: "Insurance Expiration",
                          selectedDate: $newCarModel.selectedInsuranceExpirationDate,
                          isPickerVisible: $newCarModel.isInsurancePickerVisible,
                          formatter: .date)
            }
        }.onAppear(perform: {
            carEditViewModel.prepareData(newCarModel: newCarModel, car: car)
        })
            MCButton(title: "Save", background: .blue) {
                carEditViewModel.addEditCar(context: context, newCarModel: newCarModel, car: car)
                dismiss()
                
            } .frame(height: 80)
                .padding()
        }
    }
}


