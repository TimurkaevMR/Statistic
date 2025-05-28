//
//  UserList.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

final class UserList: Decodable {
    let users: [User]
    
    func toDTO() -> [UserDTO] {
        return users.map { $0.toDTO() }
    }
}
