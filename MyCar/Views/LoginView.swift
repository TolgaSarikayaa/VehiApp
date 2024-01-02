//
//  ContentView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import SwiftUI
import SwiftData
import Combine

class KeyboardObserver: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .sink { notification in
                guard let userInfo = notification.userInfo else { return }
                guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                self.keyboardHeight = keyboardFrame.height
            }
    }
}

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @StateObject var keyboardObserver = KeyboardObserver()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                HeaderView(title: "Welcome", subtitle: "Manage your car", background: UIImage(named: "background")!)
                    .padding(.top, keyboardObserver.keyboardHeight > 0 ? -keyboardObserver.keyboardHeight : 0)
                    .animation(.easeOut)
                
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
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { notification in
                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    let keyboardHeight = keyboardSize.height
                    self.keyboardObserver.keyboardHeight = keyboardHeight
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardObserver.keyboardHeight = 0
            }
        }
        .environmentObject(keyboardObserver)
    }
}

#Preview {
    LoginView()
        
}
