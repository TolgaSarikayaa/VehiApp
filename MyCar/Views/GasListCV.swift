//
//  GasListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import SwiftUI

struct GasListCV: View {
    
    @State private var gasPrices: [String] = []
    @State private var showAlert = false
    @State private var newPrice = ""
    
    var body: some View {
        NavigationStack {
            List(gasPrices, id:\.self) { price in
                Text(price)
            }
            .navigationTitle("Gas Prices")
            .navigationBarItems(trailing: Button(action: {
                self.showAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
            .alert("Add Gas Price ", isPresented: $showAlert) {
                TextField("Price", text: $newPrice)
                Button("Save", action: save)
                Button("Cancel", role: .cancel) { }
            }
            
           }
       }
   }

func save() {
    
}

#Preview {
    GasListCV()
}
