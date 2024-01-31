//
//  CarsListCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 31.01.24.
//

import SwiftUI
import SwiftData


struct CarsListCV: View {

    @Query(sort: \CarInformation.brand, order: .forward) private var cars : [CarInformation]


    var body: some View {
        CarEditCV(cars: cars)
        
    }
}

#Preview {
    CarsListCV().modelContainer(for: [CarInformation.self])
}
