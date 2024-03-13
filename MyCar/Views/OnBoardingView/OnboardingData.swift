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
        OnboardingData(id: 0, backgroundImage: "carRegister", primaryText: "", secondaryText: ""),
        OnboardingData(id: 1, backgroundImage: "ServiceTrack", primaryText: "", secondaryText: ""),
        OnboardingData(id: 2, backgroundImage: "FuelTrack", primaryText: "", secondaryText: "")
    ]
    
}


