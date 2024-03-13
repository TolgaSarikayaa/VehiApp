//
//  OnboardingView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.03.24.
//

import SwiftUI

struct OnboardingView: View {
    
    var data: OnboardingData
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Image(data.backgroundImage)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 100)
                
            }
            Spacer()
            Spacer()
            
            Text(data.primaryText)
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))
            
            Text(data.secondaryText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 250)
                .foregroundColor(Color(red: 237 / 255, green: 203 / 255, blue: 150 / 255))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)

            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(
                                Color(
                                    red: 255 / 255,
                                    green: 115 / 255,
                                    blue: 115 / 255
                                )
                            )
                        )
            })
            .shadow(radius: 10)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView(data: OnboardingData.list.first!)
}
