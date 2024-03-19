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
    ServiceModel(partImageName: "airfilter", partName: "Luft Filter"),
    ServiceModel(partImageName: "reifen", partName: "Reifen"),
    ServiceModel(partImageName: "akku", partName: "Akku"),
    ServiceModel(partImageName: "motoroil", partName: "Motoroil"),
    ServiceModel(partImageName: "oilFilter", partName: "Oil Filter")
]
