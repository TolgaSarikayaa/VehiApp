//
//  MainTestCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 03.03.24.
//

import SwiftUI
import SwiftData

struct MainTestCV: View {
    var body: some View {
        TabView {
            CarsListCV().modelContainer(for: [CarInformation.self])
                .tabItem {
                    Label("car", systemImage: "car")
                }
            GasListTest().modelContainer(for: Gas.self, inMemory: true)
                .tabItem {
                    Label("Fuel", systemImage: "fuelpump")
                }
        }
    }
}

#Preview {
    MainTestCV()
}
