//
//  UserDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

struct UserDTO: Decodable {
    let id: Int
    let sex: Sex
    let username: String
    let isOnline: Bool
    let age: Int
    let files: [UserFileDTO]
    
    enum CodingKeys: String, CodingKey {
        case id, sex, username, isOnline, age, files
    }
}

extension UserDTO {
    func toRLM() -> UserRLM {
        UserRLM(
            id: id,
            sex: sex,
            username: username,
            isOnline: isOnline,
            age: age,
            files: files.map { $0.toRLM() }
        )
    }
}
