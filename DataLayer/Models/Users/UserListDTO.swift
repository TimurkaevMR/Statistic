//
//  UserListDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

struct UserListDTO: Decodable {
    let users: [UserDTO]
    
    func toRLM() -> [UserRLM] {
        users.map { $0.toRLM() }
    }
}
