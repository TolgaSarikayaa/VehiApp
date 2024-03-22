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
        OnboardingData(id: 0, backgroundImage: "carRegister", primaryText: "Register Your Vehicle", secondaryText: "Easily manage and monitor your vehicles."),
        OnboardingData(id: 1, backgroundImage: "ServiceTrack", primaryText: "Maintenance Management", secondaryText: "Ensure your vehicle remains in optimal condition by tracking maintenance records."),
        OnboardingData(id: 2, backgroundImage: "FuelTrack", primaryText: "Fuel Expenditure Tracking", secondaryText: "Monitor and analyze your fuel spending to optimize your driving and save money.")
    ]
    
}


