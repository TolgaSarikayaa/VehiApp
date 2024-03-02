//
//  ServiceView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.02.24.
//

import SwiftUI

struct ServiceEditCV: View {
    
   @Environment(\.dismiss) private var dismiss
    
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
                    TextField("Price", value: $parts.price, format: .number)
                    .keyboardType(.decimalPad)
                   
                    Button {
                        parts.isSelected.toggle()
                    } label: {
                        Image(systemName: parts.isSelected ? "checkmark.circle.fill" : "circle")
                    }
                    
                }
            }
        }
      
        MCButton(title: "Save", background: .blue) {
        dismiss()
        }.frame(height: 80)
          
    }
}


#Preview {
    ServiceEditCV()
}
