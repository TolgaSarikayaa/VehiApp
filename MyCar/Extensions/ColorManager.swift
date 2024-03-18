//
//  ColorManager.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.03.24.
//

import Foundation
import SwiftUI

class ColorManager: ObservableObject {
    private let colors: [Color] = [.red, .green, .blue, .orange, .purple, .yellow, .brown]
        private var colorIndex: Int = 0
        
        @Published var colorMap: [String: Color] = [:]

        func setColor(for brand: String) {
            if colorMap[brand] == nil {
                colorMap[brand] = getNextColor()
            }
        }
        
        private func getNextColor() -> Color {
            let color = colors[colorIndex % colors.count]
            colorIndex += 1
            return color
        }
    }
