//
//  GasListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import SwiftUI
import CoreData

struct GasListView: View {
    
    @Environment(\.managedObjectContext) var manageContext
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \GasEntity.date, ascending: false)],
            animation: .default)
    var gasList: FetchedResults<GasEntity>
    
    @State private var showAlert = false
    
    @State private var newPrice: String = ""
    
    private var groupedGasList: [String: [GasEntity]] {
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
                                       Text("Bought Gasoline")
                                       Spacer()
                                       Text("\(gas.price ?? "")$")
                                   }
                               }
                           }
                           
                       }
                         .onDelete(perform: deleteGas)
                
                   }
            .navigationTitle("Bought Gasoline")
            .navigationBarItems(trailing: Button(action: {
                self.showAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
            .alert("Add Gasoline", isPresented: $showAlert) {
                TextField("Price", text: $newPrice)
                    .keyboardType(.numberPad)
                Button("Add", action: { GasModelController().add(price: newPrice, context: manageContext)  })
                Button("Cancel", role: .cancel) { }
            }


             }
        
        }
    func deleteGas(at offsets: IndexSet) {
        for index in offsets {
            let gas = gasList[index]
            manageContext.delete(gas)
        }

        try? manageContext.save()
    }
    
}





