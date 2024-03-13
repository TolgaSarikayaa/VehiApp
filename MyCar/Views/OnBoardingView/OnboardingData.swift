//
//  OnboardingData.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.03.24.
//

import Foundation

struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let primaryText: String
    let secondaryText: String
    
   
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, backgroundImage: "carRegister", primaryText: "Add Your Vehicle", secondaryText: "Follow the information by adding your vehicle or vehicles"),
        OnboardingData(id: 1, backgroundImage: "ServiceTrack", primaryText: "Service Tracking", secondaryText: "Keep control of maintenance by adding your vehicle's service records"),
        OnboardingData(id: 2, backgroundImage: "FuelTrack", primaryText: "Fuel Tracking", secondaryText: "Track your fuel costs by adding the fuel you purchase")
    ]
    
}


