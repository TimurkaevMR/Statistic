//
//  UserDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

public struct UserDTO: Decodable {
    public let id: Int
    public let sex: SexDTO
    public let username: String
    public let isOnline: Bool
    public let age: Int
    public let files: [UserFileDTO]
    
    enum CodingKeys: String, CodingKey {
        case id, sex, username, isOnline, age, files
    }
}

extension UserDTO {
    func toRLM() -> UserRLM {
        UserRLM(
            id: id,
            sex: SexRLM(rawValue: sex.rawValue) ?? .other,
            username: username,
            isOnline: isOnline,
            age: age,
            files: files.map { $0.toRLM() }
        )
    }
}
