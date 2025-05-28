//
//  UserListDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

struct UserListDTO: Decodable {
    let users: [UserRLM]
    
    func toDTO() -> [UserDTO] {
        return users.map { $0.toDTO() }
    }
    ///Todo remove
    func toRLM() -> [UserRLM] {
        return users
    }
}
