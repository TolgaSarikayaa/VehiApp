//
//  GasListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import SwiftUI
import SwiftData

struct GasListCV: View {
    
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
                ForEach(prices) { price in
                    Text("\(price.price)$")
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




