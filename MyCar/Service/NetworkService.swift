//
//  NetworkService.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import Foundation

protocol NetworkService {
    func download(_ resource: String) async throws -> [CarModel]
    var type : String { get }
}
