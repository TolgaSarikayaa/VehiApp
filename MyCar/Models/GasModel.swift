//
//  GasModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.03.24.
//

import Foundation
import SwiftData

@Model
final class Gas {
    var price: String
    var timestamp: Date
    
    init(price: String, timestamp: Date) {
        self.price = price
        self.timestamp = timestamp
    }
}
