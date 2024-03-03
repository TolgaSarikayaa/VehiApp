//
//  GasListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import SwiftUI
import SwiftData

struct GasListView: View {
    
    @Query private var prices: [Gas]
    
    @Environment(\.modelContext) private var modelContext
    @State private var showAlert = false
    @State private var newPrice = ""
    @ObservedObject var gasModel = GasPriceModel()
    @ObservedObject var gasViewModel = GasViewModel()
    
    
    var body: some View {
        NavigationStack {
            List {
                if prices.isEmpty {
                
                } else {
                    let groupedPrices = prices.groupedByDate()
                    ForEach(groupedPrices.keys.sorted(), id: \.self) { key in
                        let values = groupedPrices[key]!
                        Section(header: Text(key.toFormattedString())) {
                            ForEach(values, id: \.self) { gas in
                                HStack {
                                    Image(systemName: "fuelpump.fill")
                                    .foregroundColor(.green)
                                    Text("Bought Gasoline")
                                    Spacer()
                                    Text("\(gas.price)$")
                                }
                            }
                            
                        }
                        
                        
                    }
                    .onDelete(perform: deleteItems)
                    
                    
                }
                   
            }
            .navigationTitle("Bought Gasoline")
            .navigationBarItems(trailing: Button(action: {
                self.showAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
            .alert("Add Gas Price ", isPresented: $showAlert) {
                TextField("Price", text: $gasModel.newPrice)
                    .keyboardType(.numberPad)
                Button("Save", action: { gasViewModel.addGas(context: modelContext, gasModel: gasModel) })
                Button("Cancel", role: .cancel) { }
            }
        }
        
    }
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(prices[index])
        }
        
    }
    
    
}

extension Collection where Iterator.Element == Gas {
    func groupedByDate() -> [Date: [Gas]] {
        let initial: [Date: [Gas]] = [:]
        let grouped = self.reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents([.year, .month, .day], from: cur.timestamp)
            if let date = Calendar.current.date(from: components) {
                acc[date, default: []].append(cur)
            }
        }
        return grouped
    }
}

extension Date {
    func toFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

