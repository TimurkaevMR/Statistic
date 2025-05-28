//
//  UserListDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 28.05.2025.
//

import Foundation

struct UserListDTO: Decodable {
    let users: [UserDTO]
    
    func toRealm() -> [User] {
        return users.map { $0.toRealm() }
    }
}
