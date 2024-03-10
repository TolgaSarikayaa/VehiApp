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
                    .padding(.horizontal, 22)
                    .padding(.vertical, 11)
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
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(.horizontal, 23)
                    .padding(.vertical, 11)
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .overlay(
                        Image(systemName: "envelope.circle")
                            .foregroundStyle(.gray),
                        alignment: .leading
                    )
                Spacer()
                
            }
            
            HStack {
                Spacer()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .padding(.horizontal, 22)
                    .padding(.vertical, 11)
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
