//
//  ServiceView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.02.24.
//

import SwiftUI

struct ServiceView: View {
    
    @State private var carPart = carParts
    @State private var showingAddPartView = false
    
    var body: some View {
        List {
            ForEach($carPart) { $parts in
                HStack {
                    Image(parts.partImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text(parts.partName)
                    Spacer()
                    if let price = parts.price {
                        Text("\(price, specifier: "%.2f") $")
                    } else {
                        TextField("Price", value: $parts.price, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    Button {
                        parts.isSelected.toggle()
                    } label: {
                        Image(systemName: parts.isSelected ? "checkmark.circle.fill" : "circle")
                    }
                    
                }
            }
        }
        .navigationTitle("Servise Info")
        
        MCButton(title: "Save", background: .blue) {
            
        }.frame(height: 80)
          
      
    }
}


#Preview {
    ServiceView()
}
