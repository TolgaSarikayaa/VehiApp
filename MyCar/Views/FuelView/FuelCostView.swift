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
    @State private var averagefuelConsumption = ""
    @Binding var show: Bool
    @State private var fuelConsumption: Double? = nil
    @State private var totalCost: Double? = nil
    @State private var selectedSegment = 0
    

    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                show.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray, Color(.systemGray6))
            }
            
            Picker("Select Calculation", selection: $selectedSegment) {
                Text("Fuel Consumption").tag(0)
                Text("Total Cost").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSegment == 0 {
                TextField("Fuel price", text: $fuelPrice)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("Overed Track (Km)", text: $overedTrack)
                    .padding()
                    .keyboardType(.decimalPad)
            } else {
                TextField("total distance to travel", text: $overedTrack)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("average fuel consumption", text: $averagefuelConsumption)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("fuel liter price", text: $fuelLiterPrice)
                    .padding()
                    .keyboardType(.decimalPad)
            }
           
                
        }
        
        VStack(alignment: .trailing) {
            if let consumption = fuelConsumption, selectedSegment == 0 {
                Text("Fuel consumption: \(consumption, specifier: "%.2f") L/100km")
            } else if let cost = totalCost, selectedSegment == 1 {
                Text("Fuel consumption: \(cost, specifier: "%.2f") $")
            }
        }
        
        HStack(spacing: 24){
            MCButton(title: "calculate", background: Color.blue) {
                if selectedSegment == 0 {
                    calculateFuelConsumption()
                } else {
                    calculateTotalCost()
                }
            }
        }.frame(height: 80)
         .padding(.horizontal)
        }
    
    private func calculateFuelConsumption() {
        guard let fuelPriceDouble = Double(fuelPrice) , let overedTrackDouble = Double(overedTrack), overedTrackDouble > 0 else {
            
            fuelConsumption = nil
            return
        }
        
        let consumption = (fuelPriceDouble / overedTrackDouble) * 100
        fuelConsumption = consumption
    }
    
    private func calculateTotalCost() {
        guard let totalDistance = Double(overedTrack), let averagefuelConsumption = Double(averagefuelConsumption), let fuelLiterPrice = Double(fuelLiterPrice), fuelLiterPrice > 0 else {
            
            totalCost = nil
            return
        }
        
        let calculateTotal = (totalDistance / 100) * averagefuelConsumption
        let calculateFuel = calculateTotal * fuelLiterPrice
        totalCost = calculateFuel
    }
}

#Preview {
    FuelCostView(show: .constant(false))
}
