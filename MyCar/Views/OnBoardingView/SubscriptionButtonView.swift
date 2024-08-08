//
//  SubscriptionButtonView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 08.08.24.
//

import SwiftUI

struct SubscriptionButtonView: View {
        var label: String
        var planName: String
        var price: String
        var isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                Text(planName)
                    .font(.headline)
                    //.padding(.top, 10)
                
                Text(price)
                    .font(.subheadline)
                
                //Spacer()
            }
            
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.green : Color.gray, lineWidth: 2)
            )
            
            if !label.isEmpty {
                Text(label)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(6)
                    .background(Color.white)
                    .cornerRadius(6)
                    .offset(x: 8, y: -8)
                
            }
        }
        .padding(.horizontal)
        
    }
}


