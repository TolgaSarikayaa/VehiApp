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
    @State private var showCalculate = false
    
    @State private var newPrice: String = ""
    @State private var fuelStats: [FuelStats] = []
    var fuelTipView = fuelTip()
    
    private var groupedFuelList: [String: [FuelEntity]] {
          Dictionary(grouping: fuelList) { fuel in
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .medium
              return dateFormatter.string(from: fuel.date ?? Date())
          }
      }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
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
                                        Text("\((fuel.carBrand) ?? "")")
                                        Text("\((fuel.carModel) ?? "")")
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
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        MCButton(title: "Calculate fuel cost", background: Color.orange) {
                            showCalculate = true
                        }
                        .frame(width: 200,height: 75)
                        .padding(.trailing, 2)
                        .padding(.bottom, 10)
                    }
               }
            }
            
            .navigationTitle("Fuels Purchased")
            .navigationBarItems(trailing: Button(action: {
                self.showAlert = true
            }, label: {
                Image(systemName: "plus.app")
                .popoverTip(fuelTipView)
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
            
            .sheet(isPresented: $showCalculate, content: {
                FuelCostView(show: $showCalculate)
                .presentationDetents([.height(370)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(370)))
                .presentationCornerRadius(12)
            })
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





