//
//  FuelCostView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.07.24.
//

import SwiftUI

struct FuelCostView: View {
    @State private var fuelPrice = ""
    @State private var overedTrack = ""
    @Binding var show: Bool
    @State private var fuelConsumption: Double? = nil
    

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
                
            
            VStack(alignment: .leading){
                TextField("Fuel price", text: $fuelPrice)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("Overed Track (Km)", text: $overedTrack)
                    .padding()
                    .keyboardType(.decimalPad)
        }

            if let consumption = fuelConsumption {
                    Text("Fuel consumption: \(consumption, specifier: "%.2f") L/100km")
                    .padding()
            }
            
        }
        
        HStack(spacing: 24){
            MCButton(title: "calculate", background: Color.blue) {
                calculateFuelConsumption()
                
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
}


#Preview {
    FuelCostView(show: .constant(false))
}
