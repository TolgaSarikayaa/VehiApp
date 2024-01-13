//
//  AddNewCarCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct AddNewCarCV: View {
    
    @ObservedObject var carListViewModel : CarListViewModel
    @State private var selectedBrandIndex = 0
    @State private var selectedModelIndex = 0
    @State private var isPickerVisible = false
    @State private var isDatePickerVisible = false
    @State private var isBrandPickerVisible = false
    @State private var isModelPickerVisible = false
    @State private var selectedBrand: String = ""
    @State private var selectedModel: String = ""
    @State private var selectedDate = Date()
    @State private var milage: String = ""
    
    init() {
        self.carListViewModel = CarListViewModel(service: LocalService())
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                Section(header: Text("Select Brand and Model")) {
                    HStack {
                        TextField("Select Brand", text: $selectedBrand)
                            .disabled(true)
                        
                        Spacer()
                        
                        Button(action: {
                            isBrandPickerVisible.toggle()
                        }) {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isBrandPickerVisible.toggle()
                    }

                    if isBrandPickerVisible {
                        Picker(selection: $selectedBrandIndex, label: Text("")) {
                            ForEach(carListViewModel.carList.indices, id: \.self) { index in
                                Text(carListViewModel.carList[index].brand)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedBrandIndex) { _ in
                            selectedBrand = carListViewModel.carList[selectedBrandIndex].brand
                            isBrandPickerVisible.toggle()
                        }
                    }

                    HStack {
                        TextField("Select Model", text: $selectedModel)
                            .disabled(true)
                        
                        Spacer()
                        
                        Button(action: {
                            isModelPickerVisible.toggle()
                        }) {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isModelPickerVisible.toggle()
                    }
                    
                    if isModelPickerVisible {
                        let selectedBrandModels = carListViewModel.carList[selectedBrandIndex].models
                        
                        Picker(selection: $selectedModelIndex, label: Text("")) {
                            ForEach(selectedBrandModels.indices, id: \.self) { index in
                                Text(selectedBrandModels[index])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedModelIndex) { _ in
                            selectedModel = selectedBrandModels[selectedModelIndex]
                            isModelPickerVisible.toggle()
                        }
                        
                    }

                }
            
                Section(header: Text("Select release date")) {
                    HStack {
                        Text("Date: \(selectedDate, formatter: DateFormatter.date)")
                            .onTapGesture {
                                isDatePickerVisible.toggle()
                            }
                        
                        Spacer()
                        
                        Button(action: {
                            isDatePickerVisible.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                    if isDatePickerVisible {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                }
                Section(header:Text("Select milage information")) {
                    HStack {
                        TextField("Enter Milage", text: $milage)
                            .keyboardType(.numberPad)
                    }
                }
                
            }
            .task {
                await carListViewModel.downloadCars()
            }
            .navigationTitle("Add New Car")
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
    AddNewCarCV()
}
