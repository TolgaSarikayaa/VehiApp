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
    @State private var selectedSubscription: SubscriptionType?
    
    
    
    var body: some View {
        VStack {
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
                selectedSubscription = .monthly
            } label: {
               SubscriptionButtonView(
                label: "",
                planName: "Monthly" ,
                price: "4.99$",
                isSelected: selectedSubscription == .monthly)
            }
            
            .padding(.bottom)
            
            Button {
                selectedSubscription = .annual
            } label: {
              SubscriptionButtonView(
                label: "MOST POPULAR",
                planName: "Annual",
                price: "29.99$",
                isSelected: selectedSubscription == .annual)
            }
            
            .padding(.bottom)
            
            Button {
              subscribeUser()
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
        guard let subscription = selectedSubscription else {
          showAlert = true
            return
        }
        
        switch subscription {
        case .monthly:
            print("Monthly subscription selected")
        case .annual:
            print("Annual subscription selected")
        }
        
        isSubscribed = true
        showAlert = true
    }
    
    enum SubscriptionType {
            case monthly
            case annual
    }
}

#Preview {
    paywallView()
}
