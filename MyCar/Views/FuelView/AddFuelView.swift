//
//  AddFuelView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 09.03.24.
//

import SwiftUI
import CoreData

struct AddFuelView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var cars: [NewCarEntity] = []
    @State private var fuelPrice: String = ""
    @State private var drivers: [String] = []
    @State private var selectedDriverIndex: Int?
    @State private var selectedCarIndex: Int?
    
    var isInputValid: Bool {
        let normalizedFuelPrice = fuelPrice.replacingOccurrences(of: ",", with: ".")
            return Double(normalizedFuelPrice) != nil && normalizedFuelPrice.count <= 7 && !normalizedFuelPrice.isEmpty
       }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Select Car")) {
                    Picker("Select Car", selection: $selectedCarIndex) {
                        ForEach(cars.indices, id: \.self) { index in
                            Text("\(cars[index].brand ?? "Unknown Brand") \(cars[index].model ?? "")").tag(index as Int?)
            
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedCarIndex) { old , new in
                        updateDriversList()
                   }
                }
                
                Section(header: Text("Select Driver")) {
                    Picker("Driver", selection: $selectedDriverIndex) {
                        ForEach(drivers.indices, id: \.self) { index in
                            Text(drivers[index]).tag(index as Int?)
                        }
                        if drivers.isEmpty {
                            Text(NSLocalizedString("Self", comment: "Driver is self")).tag(nil as Int?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onReceive([self.selectedDriverIndex].publisher.first()) { (value) in
                        if let index = value, index >= drivers.count {
                        selectedDriverIndex = nil
                        }
                    }
                }
                
                Section(header: Text("Add Price")) {
                    TextField("Fuel Price", text: $fuelPrice)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Fuel")
            .onAppear {
                fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        MCButton(title: "Save", background: .blue, action: {
            let normalizedFuelPrice = fuelPrice.replacingOccurrences(of: ",", with: ".")
            if let index = selectedCarIndex, cars.indices.contains(index), let price = Double(normalizedFuelPrice) {
                if let driverIndex = selectedDriverIndex, drivers.indices.contains(driverIndex) || selectedDriverIndex == nil {
                    let car = cars[index]
                    let driver = selectedDriverIndex.flatMap { drivers.indices.contains($0) ? drivers[$0] : "Self" }
                    addFuel(carBrand: car.brand ?? "", carModel: car.model ?? "", price: price, carUser: driver ?? "")
                }
            }
            dismiss()
        }).frame(height: 80)
         
         .disabled(!isInputValid)
    }
    
    
    private func addFuel(carBrand: String, carModel: String,price: Double, carUser: String) {
        let fuel = FuelEntity(context: managedObjectContext)
        fuel.id = UUID()
        fuel.price = price
        fuel.date = Date()
        fuel.carBrand = carBrand
        fuel.carModel = carModel
        fuel.carUser = carUser
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchData() {
        let request: NSFetchRequest<NewCarEntity> = NewCarEntity.fetchRequest()
        request.entity = NSEntityDescription.entity(forEntityName: "NewCarEntity", in: managedObjectContext)
        do {
            cars = try managedObjectContext.fetch(request)
            updateDriversList()
            if !cars.isEmpty {
                selectedCarIndex = 0
            }
            if !drivers.isEmpty {
                selectedDriverIndex = 0
            }
        } catch(let error) {
            print("Error fetching cars: \(error)")
        }
    }

    
    private func updateDriversList() {
            if let selectedCarIndex = selectedCarIndex {
                let car = cars[selectedCarIndex]
                drivers = car.user?.split(separator: ",").map(String.init) ?? []
                if drivers.isEmpty {
                    drivers.append(NSLocalizedString("Self", comment: "Driver is self"))
                }
            } else {
                drivers = []
            }
            selectedDriverIndex = drivers.isEmpty ? nil : 0
        }
}


extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
