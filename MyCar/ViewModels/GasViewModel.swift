//
//  GasViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 03.03.24.
//

import Foundation
import SwiftData

class GasViewModel : ObservableObject {
    
    func addGas(context: ModelContext, gasModel: GasPriceModel) {
        let newGas = Gas(price: gasModel.newPrice, timestamp: Date())
        context.insert(newGas)
        
     
        
    }
    
}
