//
//  GasListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import SwiftUI
import CoreData

struct FuelListView: View {
    
    @Environment(\.managedObjectContext) var manageContext
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \FuelEntity.date, ascending: false)],
            animation: .default)
    var gasList: FetchedResults<FuelEntity>
    @StateObject var modelController = FuelModelController()
    
    @State private var showAlert = false
    
    @State private var newPrice: String = ""
    
    private var groupedGasList: [String: [FuelEntity]] {
          Dictionary(grouping: gasList) { gas in
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .medium
              return dateFormatter.string(from: gas.date ?? Date())
          }
      }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedGasList.keys.sorted(), id: \.self) { date in
                           Section(header: Text(date)) {
                               ForEach(groupedGasList[date] ?? []) { gas in
                                   HStack {
                                       Image(systemName: "fuelpump.fill")
                                           .foregroundColor(.green)
                                       Text("Fuel Purchased")
                                       Spacer()
                                       Text("\(gas.price ?? "")$")
                                   }
                               }
                           }
                           
                       }
                         .onDelete(perform: deleteFuel)
                
                   }
            .navigationTitle("Fuels Purchased")
            .navigationBarItems(trailing: Button(action: {
                self.showAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
            .alert("Add Fuel", isPresented: $showAlert) {
                TextField("Price", text: $newPrice)
                    .keyboardType(.numberPad)
                Button("Add", action: { modelController.add(price: newPrice, context: manageContext) 
                 newPrice = ""  })
                Button("Cancel", role: .cancel) { }
            }


             }
        
        }
    func deleteFuel(at offsets: IndexSet) {
        for index in offsets {
            let gas = gasList[index]
            manageContext.delete(gas)
        }

        try? manageContext.save()
    }
    
}





