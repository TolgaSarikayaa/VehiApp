//
//  ColorManager.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.03.24.
//

import Foundation
import SwiftUI

class ColorManager: ObservableObject {
    @Published var colorMap: [String : Color] = [:]
    private var usedColors: Set<Color> = []

        func setColor(for brand: String) {
            if colorMap[brand] == nil {
                var newColor = Color.random
                
                while usedColors.contains(newColor) {
                    newColor = Color.random
                }
                
                colorMap[brand] = newColor
                usedColors.insert(newColor)
                
            }
        }
    }
