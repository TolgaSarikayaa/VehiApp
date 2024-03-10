//
//  GasListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import SwiftUI
import CoreData

struct FuelListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest( entity: FuelEntity.entity(),
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
                               ForEach(groupedGasList[date] ?? []) { fuel in
                                   HStack {
                                       Image(systemName: "fuelpump.fill")
                                           .foregroundColor(.green)
                                       Text("Fuel Purchased: \((fuel.carBrand) ?? "")")
                                       Spacer()
                                       Text("\((fuel.price) ?? "")$")
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
            .sheet(isPresented: $showAlert) {
                         
                AddFuelView().environment(\.managedObjectContext, managedObjectContext)
                }
             }
        }
    func deleteFuel(at offsets: IndexSet) {
        for index in offsets {
            let fuel = gasList[index]
            managedObjectContext.delete(fuel)
        }
        try? managedObjectContext.save()
    }
}





