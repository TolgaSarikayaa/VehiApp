//
//  RegisterView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.01.24.
//

import SwiftUI
import Combine


struct RegisterView: View {
   @StateObject var viewModel = RegisterViewViewModel()
    
    
    var body: some View {
      
        VStack {
            // Header
            HeaderView(title: "Register", subtitle: "Start today", background: UIImage(named: "background")!)
            
            HStack {
               Spacer()
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                Spacer()
                
            }
            HStack {
                Spacer()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
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
                    .foregroundColor(.black)
                Spacer()
            }
            
            MCButton(title: "Creat Account", background: .green) {
                // Attempt log in
                viewModel.register()
            }
            .frame(height: 80)
        }
        .offset(y: -90)
    }

}
        
#Preview {
    RegisterView()
}
