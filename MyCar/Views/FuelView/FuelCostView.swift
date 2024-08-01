//
//  FuelCostView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.07.24.
//

import SwiftUI

struct FuelCostView: View {
    @State private var fuelPrice = ""
    @State private var fuelLiterPrice = ""
    @State private var overedTrack = ""
    @State private var overedTrack2 = ""
    @State private var averagefuelConsumption = ""
    @Binding var show: Bool
    @State private var fuelConsumption: Double? = nil
    @State private var totalCost: Double? = nil
    @State private var selectedSegment = 0
    
    private var isUsingMiles: Bool {
        let locale = Locale.current
        return locale.measurementSystem == .us
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Picker("Select Calculation", selection: $selectedSegment) {
                Text("Fuel Consumption").tag(0)
                Text("Total Cost").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSegment == 0 {
                TextField(isUsingMiles ? "Fuel purchased (gallons)" : "Fuel purchased (liters)", text: $fuelPrice)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                TextField(isUsingMiles ? "Miles driven" : "Kilometers driven", text: $overedTrack)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
            } else {
                TextField(isUsingMiles ? "Total distance to travel (miles)" : "Total distance to travel (km)", text: $overedTrack2)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                TextField(isUsingMiles ? "Average fuel consumption (MPG)" : "Average fuel consumption (L/100km)", text: $averagefuelConsumption)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                TextField(isUsingMiles ? "Fuel price per gallon" : "Fuel price per liter", text: $fuelLiterPrice)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
            }
        }
        
        VStack(alignment: .trailing) {
            if let consumption = fuelConsumption, selectedSegment == 0 {
                Text("Fuel consumption: \(consumption, specifier: "%.2f") \(isUsingMiles ? "MPG" : "L/100km")")
            } else if let cost = totalCost, selectedSegment == 1 {
                Text("Fuel consumption: \(cost, specifier: "%.2f") $")
            }
        }
        Spacer()
        
        HStack(spacing: 24) {
            MCButton(title: NSLocalizedString("Calculate", comment: ""), background: Color.blue) {
                if selectedSegment == 0 {
                    calculateFuelConsumption()
                } else {
                    calculateTotalCost()
                }
            }
        }
        .frame(height: 80)
         .padding(.horizontal)
         .padding(.bottom, 20)
    }
        
    
    private func calculateFuelConsumption() {
        let normalizedFuelPrice = fuelPrice.replacingOccurrences(of: ",", with: ".")
        let normalizedOveredTrack = overedTrack.replacingOccurrences(of: ",", with: ".")
        guard let fuelPriceDouble = Double(normalizedFuelPrice), let overedTrackDouble = Double(normalizedOveredTrack), overedTrackDouble > 0 else {
            
            fuelConsumption = nil
            return
        }
        
        if isUsingMiles {
            let consumption = overedTrackDouble / fuelPriceDouble
            fuelConsumption = consumption
        } else {
            let consumption = (fuelPriceDouble / overedTrackDouble) * 100
            fuelConsumption = consumption
        }
    }
    
    private func calculateTotalCost() {
        let normalizedTotalDistance  = overedTrack2.replacingOccurrences(of: ",", with: ".")
        let normalizedAverageFuelConsumption = averagefuelConsumption.replacingOccurrences(of: ",", with: ".")
        let normalizedFuelLiterPrice = fuelLiterPrice.replacingOccurrences(of: ",", with: ".")
        guard let totalDistance = Double(normalizedTotalDistance), let averagefuelConsumption = Double(normalizedAverageFuelConsumption), let fuelLiterPrice = Double(normalizedFuelLiterPrice), fuelLiterPrice > 0 else {
            
            totalCost = nil
            return
        }
        if isUsingMiles {
            let calculateTotal = totalDistance / averagefuelConsumption
            let calculateFuel = calculateTotal * fuelLiterPrice
            totalCost = calculateFuel
        }
        let calculateTotal = (totalDistance / 100) * averagefuelConsumption
        let calculateFuel = calculateTotal * fuelLiterPrice
        totalCost = calculateFuel
    }
}

#Preview {
    FuelCostView(show: .constant(false))
}
