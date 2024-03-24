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
            OnboardingData(
                id: 0,
                backgroundImage: "carRegister",
                primaryText: NSLocalizedString("Register Your Vehicle", comment: "Onboarding primary text for registering vehicle"),
                secondaryText: NSLocalizedString("Easily manage and monitor your vehicles.", comment: "Onboarding secondary text for registering vehicle")
            ),
            OnboardingData(
                id: 1,
                backgroundImage: "ServiceTrack",
                primaryText: NSLocalizedString("Maintenance Management", comment: "Onboarding primary text for maintenance management"),
                secondaryText: NSLocalizedString("Ensure your vehicle remains in optimal condition by tracking maintenance records.", comment: "Onboarding secondary text for maintenance management")
            ),
            OnboardingData(
                id: 2,
                backgroundImage: "FuelTrack",
                primaryText: NSLocalizedString("Fuel Expenditure Tracking", comment: "Onboarding primary text for fuel tracking"),
                secondaryText: NSLocalizedString("Monitor and analyze your fuel spending to optimize your driving and save money.", comment: "Onboarding secondary text for fuel tracking")
            )
        ]
    }


