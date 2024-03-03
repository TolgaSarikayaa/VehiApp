//
//  GasListTest.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 03.03.24.
//

import SwiftUI
import SwiftData

struct GasListCV: View {
    

    var body: some View {
        GasListView()
    }
}

#Preview {
    GasListCV().modelContainer(for: Gas.self, inMemory: true)
}
