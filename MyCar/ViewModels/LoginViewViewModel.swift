//
//  LoginViewViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.01.24.
//

import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var erroMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
    }
    
    func validate() -> Bool {
        erroMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            erroMessage = "Password fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            erroMessage = "Please enter valid email."
            return false
        }
        
        return true
        
    }
}
