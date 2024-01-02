//
//  ContentView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
 
    var body: some View {
            NavigationStack {
                VStack {
                    // Header
                    HeaderView(title: "Welcome", subtitle: "Manage your car", background: UIImage(named: "background")!)
                    
                    Spacer()
                    
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
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .cornerRadius(8)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(DefaultTextFieldStyle())
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .cornerRadius(8)
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
                        NavigationLink("Create An Account", destination: RegisterView())
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }

#Preview {
    LoginView()
        
}
