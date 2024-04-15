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
    var date = Date()
}

let carParts = [
    ServiceModel(partImageName: "bremse", partName: NSLocalizedString("Brake", comment: "Part name for Brake")),
    ServiceModel(partImageName: "airfilter", partName: NSLocalizedString("Air Filter", comment: "Part name for Air Filter")),
    ServiceModel(partImageName: "reifen", partName: NSLocalizedString("Wheel", comment: "Part name for Wheel")),
    ServiceModel(partImageName: "akku", partName: NSLocalizedString("Battery", comment: "Part name for Battery")),
    ServiceModel(partImageName: "motoroil", partName: NSLocalizedString("Motor oil", comment: "Part name for Motor oil")),
    ServiceModel(partImageName: "oilFilter", partName: NSLocalizedString("Oil Filter", comment: "Part name for Oil Filter")),
    ServiceModel(partImageName: "Kühlflüssigkeit", partName: NSLocalizedString("Coolant",comment: "Part name for coolant")),
    ServiceModel(partImageName: "carWipers", partName: NSLocalizedString("Wipers",comment: "Part name for wipers"))
]
