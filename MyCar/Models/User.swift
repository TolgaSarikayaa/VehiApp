//
//  User.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.01.24.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name : String
    var email : String
    var joined : TimeInterval
    
}
