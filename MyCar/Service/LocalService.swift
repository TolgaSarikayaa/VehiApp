//
//  LocalService.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import Foundation

class LocalService : NetworkService {
    var type: String = "Localservice"
    
    func download(_ resource: String) async throws -> [CarModel] {
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            fatalError("Resource not found")
        }
        
        let data = try Data(contentsOf: URL(filePath: path))
        
        return try JSONDecoder().decode([CarModel].self, from: data)
    }
    
    
    
}
