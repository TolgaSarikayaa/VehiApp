//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct CarEditCV: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                Text("Test")
            }
            .navigationTitle("My Cars")
            .navigationBarItems(trailing: Button(action: {
                        
                    }) {
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                    })
        }
    }
}

#Preview {
    CarEditCV()
}
