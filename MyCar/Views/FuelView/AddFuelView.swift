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
    @State private var selectedCarIndex: Int?
    
    var isInputValid: Bool {
           Double(fuelPrice) != nil && fuelPrice.count <= 7 && !fuelPrice.isEmpty
       }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Select Car")) {
                    Picker("Select Car", selection: $selectedCarIndex) {
                        ForEach(cars.indices, id: \.self) { index in
                            Text(cars[index].brand ?? "Unknown Brand").tag(index as Int?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onReceive([self.selectedCarIndex].publisher.first()) { (value) in
                        if let index = value, index >= cars.count {
                            selectedCarIndex = nil
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
            if let index = selectedCarIndex, cars.indices.contains(index), let price = Double(fuelPrice) {
                let car = cars[index]
                addFuel(carBrand: car.brand ?? "", price: price)
            }
            dismiss()
        }).frame(height: 80)
         
         .disabled(!isInputValid)
    }
    
    
    private func addFuel(carBrand: String, price: Double) {
        let fuel = FuelEntity(context: managedObjectContext)
        fuel.id = UUID()
        fuel.price = price
        fuel.date = Date()
        fuel.carBrand = carBrand
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchData() {
        let request: NSFetchRequest<NewCarEntity> = NewCarEntity.fetchRequest()
        do {
            cars = try managedObjectContext.fetch(request)
            if !cars.isEmpty {
                    selectedCarIndex = 0
                 }
        } catch(let error) {
            print("Error fetching cars: \(error)")
        }
    }
}

