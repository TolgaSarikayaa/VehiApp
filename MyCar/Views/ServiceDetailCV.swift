//
//  ServiceDetailCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 18.02.24.
//

import SwiftUI

struct ServiceDetailCV: View {
    
    @State private var isNavigationActive = false
    @State private var services = [String]()
    
    var body: some View {
        HStack {
            // Liste içeriğine göre koşullu görünüm
            if services.isEmpty {
                // Liste boşken gösterilecek mesaj
                Text("Add Service Information")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Merkeze almak için
                    .background(Color(UIColor.systemBackground)) // Arka plan rengi
                
            } else {
                // Liste doluysa gösterilecek liste elemanları
                List(services, id: \.self) { service in
                    Text(service)
                }
                
               
                
            }
        }  .navigationBarItems(trailing: Button(action: {
            isNavigationActive.toggle()
        }) {
            Image(systemName: "plus.app")
        })
        .sheet(isPresented: $isNavigationActive) {
            ServiceEditCV()
        }
        .navigationTitle("Service Info")
    }
    
}
        
    
    
#Preview {
    ServiceDetailCV()
}
