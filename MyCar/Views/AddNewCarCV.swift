//
//  AddNewCarCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct AddNewCarCV: View {
    
    @ObservedObject var carListViewModel : CarListViewModel
    
    init() {
        self.carListViewModel = CarListViewModel(service: LocalService())
    }
    
    var body: some View {
        List(carListViewModel.carList, id: \.brand) { cars in
                VStack {
                    Text(cars.brand)
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
        }.task {
            await carListViewModel.downloadCars()
        }
        
    }
}

#Preview {
    AddNewCarCV()
}
