//
//  GasListTest.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 03.03.24.
//

import SwiftUI
import SwiftData

struct GasListTest: View {
    
   
    
    var body: some View {
        GasListCV()
    }
}

#Preview {
    GasListTest().modelContainer(for: Gas.self, inMemory: true)
}
