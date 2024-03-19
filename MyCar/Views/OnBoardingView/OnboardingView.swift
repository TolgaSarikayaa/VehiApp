//
//  OnboardingView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.03.24.
//

import SwiftUI

struct OnboardingView: View {
    
    var data: OnboardingData
    @State private var isOnboardingFinished = false
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
  
    
    var body: some View {
       GeometryReader { geometry in
                VStack(spacing: 20) {
                    ZStack {
                        Image(data.backgroundImage)
                            .resizable()
                            .scaledToFit()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 3)
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
                    
                    NavigationLink(destination: MainCV()) {
                        Button("Get Started") {
                            isOnboardingFinished.toggle()
                            isFirstLaunch.toggle()
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 255 / 255, green: 115 / 255, blue: 115 / 255)))
                    }
                    .shadow(radius: 10)
                    .padding(.vertical,60)
                }
                
            }
    }
}

#Preview {
    OnboardingView(data: OnboardingData.list.first!)
}

