//
//  MainTestCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 03.03.24.
//

import SwiftUI
import SwiftData

struct MainCV: View {
    var body: some View {
        TabView {
            CarsListCV()
                .tabItem {
                    Label("Cars", systemImage: "car")
                }
            FuelListView()
                .tabItem {
                    Label("Fuel", systemImage: "fuelpump")
                }
            ServiceDetailCV()
                .tabItem {
                    Label("Service", systemImage: "wrench.and.screwdriver")
            }
        }
    }
}

#Preview {
    MainCV()
}
