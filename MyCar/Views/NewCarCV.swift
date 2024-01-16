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
    @State private var isDatePickerVisible = false
    @State private var isBrandPickerVisible = false
    @State private var isModelPickerVisible = false
    @State private var selectedBrand: String = ""
    @State private var selectedModel: String = ""
    @State private var selectedDate = Date()
    @State private var milage: String = ""
    @State private var selectedEngineType: CarInformation.EngineType = .benzin
    
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
                        Picker("Select Engine type", selection: $selectedEngineType) {
                                    ForEach(CarInformation.EngineType.allCases, id: \.self) { engineType in
                                        Text(engineType.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Text("Select release date: \(selectedDate, formatter: DateFormatter.date)")
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
                   
                    HStack {
                        TextField("Enter Milage", text: $milage)
                            .keyboardType(.numberPad)
                    }
                }
                
            }
            
        }
        .task {
            await carListViewModel.downloadCars()
        }
        .navigationTitle("Add New Car")
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
