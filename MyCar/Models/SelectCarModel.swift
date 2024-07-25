//
//  NewCarModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 22.01.24.
//

import Foundation
import UIKit

class SelectCarModel : ObservableObject {
       @Published var selectedBrandIndex = 0
       @Published var selectedModelIndex = 0
       @Published var isPickerVisible = false
       @Published var isReleaseDatePickerVisible = false
       @Published var isLastServiceDatePickerVisible = false
       @Published var isNextServiceDatePickerVisible = false
       @Published var isBrandPickerVisible = false
       @Published var isModelPickerVisible = false
       @Published var selectedBrand: String = ""
       @Published var selectedModel: String = ""
       @Published var selectedReleaseDate = Date()
       @Published var selectedLastServiceDate = Date()
       @Published var selectedNextServiceDate = Date()
       @Published var selectedInsuranceExpirationDate = Date()
       @Published var isInsurancePickerVisible = false
       @Published var mileage: String = ""
       @Published var selectedFuelType: EngineType = .benzin
       @Published var isNavigationActive = false
       @Published var selectedLicensePlate: String = ""
       @Published var selectedImage: UIImage?
       @Published var selectedUser: String = ""
       @Published var selectedUserImage: UIImage?
    
}

