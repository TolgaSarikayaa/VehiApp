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
                    
                }.toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            isNavigationActive = true
                        }, label: {
                            Text("Add")
                        })
                    }
                }.sheet(isPresented: $isNavigationActive, content: {
                    ServiceView()
                })
            }
        }
    

#Preview {
    ServiceDetailCV()
}
