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
        NavigationStack {
            TabView {
                HStack {
                    
                    Text("Service")
                    
                    
                }  .tabItem {
                    Label("Service", systemImage: "gear")
                }
                
                
            }      .navigationBarItems(trailing: Button(action: {
                isNavigationActive.toggle()
            }) {
                Text("Edit")
            })
        }
    }
        
}
    


#Preview {
    ServiceDetailCV()
}
