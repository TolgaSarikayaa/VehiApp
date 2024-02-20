//
//  ServiceDetailCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 18.02.24.
//

import SwiftUI

struct ServiceDetailCV: View {
    
    @State private var isNavigationActive = false
    
    var body: some View {
        List {
            HStack {
                
                
                
            }  .tabItem {
                Label("Service", systemImage: "gear")
            }
            
            .sheet(isPresented: $isNavigationActive) {
                ServiceEditCV()
            }
            .navigationBarItems(trailing: Button(action: {
                isNavigationActive.toggle()
            }) {
                Image(systemName: "plus.app")
            })
        }.navigationTitle("Service Info")
    }
}
        
    
    
#Preview {
    ServiceDetailCV()
}
