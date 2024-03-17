//
//  ColorManager.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.03.24.
//

import Foundation
import SwiftUI

class ColorManager: ObservableObject {
    @Published var colorMap: [String: Color] = [:]

    func setColor(for brand: String) {
        if colorMap[brand] == nil {
            colorMap[brand] = Color.random
        }
    }
}
