//
//  RegisterViewViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.01.24.
//

import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init() {
        
    }
    
    func register() {
        guard validate() else {
            return
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: UUID(), name: name, email: email, joined: Date().timeIntervalSince1970)
        
    
    }
    
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
                !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        guard password.count >= 6 else {
            return false
        }
       return true
    }
}
