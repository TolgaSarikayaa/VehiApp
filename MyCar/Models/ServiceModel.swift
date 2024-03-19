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
    ServiceModel(partImageName: "bremse", partName: "Brake"),
    ServiceModel(partImageName: "airfilter", partName: "Air Filter"),
    ServiceModel(partImageName: "reifen", partName: "Wheel"),
    ServiceModel(partImageName: "akku", partName: "Battery"),
    ServiceModel(partImageName: "motoroil", partName: "Motor oil"),
    ServiceModel(partImageName: "oilFilter", partName: "Oil Filter")
]
