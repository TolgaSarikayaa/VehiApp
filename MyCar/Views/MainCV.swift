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
            CarsListCV().modelContainer(for: [CarInformation.self])
                .tabItem {
                    Label("Cars", systemImage: "car")
                }
            GasListView()
                .tabItem {
                    Label("Fuel", systemImage: "fuelpump")
                }
        }
    }
}

#Preview {
    MainCV()
}
