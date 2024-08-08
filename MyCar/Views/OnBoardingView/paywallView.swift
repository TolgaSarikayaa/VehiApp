//
//  paywallView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.08.24.
//

import SwiftUI

struct paywallView: View {
    @State private var isSubscribed: Bool = false
    @State private var showAlert = false
    @State private var isMonthlyButtonTapped: Bool = false
    @State private var isAnnualButtonTapped: Bool = false
    
    
    
    var body: some View {
        VStack {
//            Image("icon")
//                .resizable()
//                .background(Color.white)
//                .cornerRadius(15)
//                .padding()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 250, height: 250)
            
            VStack(spacing: 5) {
                Text("Go Premium")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Unlock all features and enjoy better experince")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            .padding(.top, 50)
            .padding(.bottom, 50)
            //Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                    Text("Unlimited Access")
        
                }.padding(.horizontal)
            }
            .font(.headline)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            VStack {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                    Text("Unlimited Car Adding")
                }
            }
            .font(.headline)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
             Spacer()
            
            Button {
                isMonthlyButtonTapped.toggle()
            } label: {
                Text("Unlock now for $4.99 Monthly")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                     RoundedRectangle(cornerRadius: 12)
                        .stroke(isMonthlyButtonTapped ? Color.green : Color.gray, lineWidth: 2)
                    )
                    .padding(.horizontal)
            }
            
            Button {
                isAnnualButtonTapped.toggle()
            } label: {
                Text("Unlock now for $29.99 Annual")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isAnnualButtonTapped ? Color.green : Color.gray, lineWidth: 2)
                    )
                    .padding(.horizontal)
            }
            
            Button {
                
            } label: {
                Text("Go Premium")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(isSubscribed ? "Subscribed" : "Subscribed Failed"),
                    message: Text(isSubscribed ? "You have successfuly subscribed" : "Please try again"),
                    dismissButton: .default(Text("OK"))
              )
            }
            Spacer()
        }
    }
    
    private func subscribeUser() {
        // Add subscription logic here
       // This is just a placeholder for demonstration
        isSubscribed = true
        showAlert = true
    }
}

#Preview {
    paywallView()
}
