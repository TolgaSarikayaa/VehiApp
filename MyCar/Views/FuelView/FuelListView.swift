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
    
    var fuelList: FetchedResults<FuelEntity>
        
    @StateObject var modelController = FuelModelController()
    
    @State private var showAlert = false
    @State private var showDetay = false
    
    @State private var newPrice: String = ""
    @State private var fuelStats: [FuelStats] = []
    
    private var groupedFuelList: [String: [FuelEntity]] {
          Dictionary(grouping: fuelList) { fuel in
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .medium
              return dateFormatter.string(from: fuel.date ?? Date())
          }
      }
    
    var body: some View {
        NavigationStack {
            HStack {
                if groupedFuelList.isEmpty {
                    Text("Add Fuel")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(UIColor.systemBackground))
                } else {
                    List {
                        ForEach(groupedFuelList.keys.sorted(), id: \.self) { date in
                            Section(header: Text(date)) {
                                ForEach(groupedFuelList[date] ?? []) { fuel in
                                    HStack {
                                        Image(systemName: "fuelpump.fill")
                                            .foregroundColor(.green)
                                        Text("Fuel Purchased: \((fuel.carBrand) ?? "")")
                                        Spacer()
                                        Text("\(fuel.price, specifier: "%.2f")$")
                                    }
                                }
                                .onDelete { offsets in
                                    deleteFuel(at: offsets, for: date)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Fuels Purchased")
            .navigationBarItems(trailing: Button(action: {
                self.showAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
            .navigationBarItems(trailing: Button(action: {
                self.showDetay = true
            }, label: {
                Image(systemName: "chart.pie.fill")
            }))
            .sheet(isPresented: $showAlert) {
                
                AddFuelView().environment(\.managedObjectContext, managedObjectContext)
            }
            .sheet(isPresented: $showDetay) {
             FuelDetailView()
            }
        }
    }
    func deleteFuel(at offsets: IndexSet, for date: String) {
        guard let dateGroup = groupedFuelList[date] else { return }
        offsets.forEach { index in
            let fuelEntity = dateGroup[index]
            managedObjectContext.delete(fuelEntity)
        }
        try? managedObjectContext.save()
    }
    
  
}





