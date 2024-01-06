//
//  ContentView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import SwiftUI
import SwiftData
import Combine


struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
   
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                HeaderView(title: "Welcome", subtitle: "Manage your car", background: UIImage(named: "background")!)
                
                VStack {
                    if !viewModel.erroMessage.isEmpty {
                        Text(viewModel.erroMessage)
                            .foregroundColor(.red)
                    }
                    
                    HStack {
                        Spacer()
                        TextField("Email Address", text: $viewModel.email)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .autocapitalization(.none)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .overlay(
                        Image(systemName: "person.circle")
                            .foregroundColor(.gray),
                             alignment: .leading
                        )
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .overlay(
                                Image(systemName: "lock")
                                    .foregroundColor(.gray),
                                     alignment: .leading
                            )
                        Spacer()
                    }
                    
                    MCButton(title: "Log In", background: .blue) {
                        // Attempt log in
                        viewModel.login()
                    }
                    .frame(height: 80)
                    .padding()
                }
                .offset(y: -50)
                
                Spacer()
                
                // Create Account
                VStack {
                    Text("New around here?")
                        .foregroundColor(Color.white)
                    NavigationLink("Create An Account", destination: AddNewCarCV())
                }
                .padding(.bottom, 50)
             
            }
        
            }
            
        }
      
    }


#Preview {
    LoginView()
        
}
