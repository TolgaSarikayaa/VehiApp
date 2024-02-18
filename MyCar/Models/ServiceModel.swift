//
//  ServiceModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.02.24.
//

import Foundation

struct ServiceModel : Identifiable {
    var id = UUID()
    var partImageName: String
    var partName: String
    var price: Double?
    var isSelected: Bool = false
}

let carParts = [
    ServiceModel(partImageName: "bremse", partName: "Bremse"),
    ServiceModel(partImageName: "luft", partName: "Luft"),
    ServiceModel(partImageName: "reife", partName: "Reifen")
]
