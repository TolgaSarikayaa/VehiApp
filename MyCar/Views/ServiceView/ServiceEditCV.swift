//
//  ServiceView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.02.24.
//

import SwiftUI
import CoreData

struct ServiceEditCV: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) private var dismiss
    @State private var parts: [ServiceEntity] = []
    @State private var cars: [NewCarEntity] = []
    
    @State private var selectedCarIndex: Int?
    
    @State private var carPart = carParts
    @State private var showingAddPartView = false
    var carPartTip = addCarParts()
 
    
    var body: some View {
        NavigationStack {
        List {
            Section(header: Text("Select Car")) {
                Picker("Select Car", selection: $selectedCarIndex) {
                    ForEach(cars.indices, id: \.self) { index in
                        Text("\(cars[index].brand ?? "Unknown Brand") \(cars[index].model ?? "Unknown Model")").tag(index as Int?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onReceive([self.selectedCarIndex].publisher.first()) { (value) in
                    if let index = value, index >= cars.count {
                        selectedCarIndex = nil
                    }
                }
            }
            ForEach($carPart.indices, id: \.self) { index in
                HStack {
                    Image(carPart[index].partImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text(carPart[index].partName)
                    Spacer()
                    TextField("Price", value: $carPart[index].price, format: .number)
                        .keyboardType(.decimalPad)
                        .onChange(of: carPart[index].price) { newValue, oldWalue in
                            if newValue ?? 0 <= 0 {
                                carPart[index].isSelected = false
                            }
                        }
                    
                        .popoverTip(carPartTip)

                    Button {
                        if carPart[index].price != nil && carPart[index].price! > 0 {
                            carPart[index].isSelected.toggle()
                        }
                    } label: {
                        Image(systemName: carPart[index].isSelected ? "checkmark.circle.fill" : "circle")
                    }
                    .disabled(carPart[index].price == nil || carPart[index].price! > 10_00000)
                }
                
            }
        }.navigationTitle("Add Service Info")
        .onAppear {
            fetchData()
        }
       
    }
        MCButton(title: "Save", background: .blue) {
            if let selectedCarIndex = selectedCarIndex, cars.indices.contains(selectedCarIndex) {
                    saveParts(carPart.filter { $0.isSelected }, context: managedObjectContext)
                }
           
        dismiss()
        }.frame(height: 80)
    }
    
    func saveParts(_ parts: [ServiceModel], context: NSManagedObjectContext) {
        guard let selectedCarIndex = selectedCarIndex, cars.indices.contains(selectedCarIndex) else {
            return
        }
        let selectedCar = cars[selectedCarIndex]

        for part in parts where part.isSelected {
            let newPart = ServiceEntity(context: context)
            newPart.id = UUID()
            newPart.partImageName = part.partImageName
            newPart.partName = part.partName
            newPart.price = part.price ?? 0.00
            newPart.isSelected = part.isSelected
            newPart.carBrand = selectedCar.brand
            newPart.carModel = selectedCar.model
            newPart.date = Date()

            do {
                try context.save()
            } catch let error as NSError {
                print("Kaydetme hatası: \(error), \(error.userInfo)")
            }
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
#Preview {
    ServiceEditCV()
}
