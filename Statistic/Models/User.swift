//
//  User.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

final class User: Decodable {
    let id: Int
    let sex: Sex
    let username: String
    let isOnline: Bool
    let age: Int
    let files: [UserFile]
    
    init(id: Int,
         sex: Sex,
         username: String,
         isOnline: Bool,
         age: Int,
         files: [UserFile]) {
        self.id = id
        self.sex = sex
        self.username = username
        self.isOnline = isOnline
        self.age = age
        self.files = files
    }
    
    ///Тип создан для безопасного получения и отправки пола
    enum Sex: String, Codable {
        case male = "M"
        case female = "W"
        case other = "O"
        ///.other на случай если пол не указан
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = Sex(rawValue: rawValue) ?? .other
        }
    }
}

// MARK: - Mock Data
extension User {
    static var mock: User {
        User(
            id: 1,
            sex: .male,
            username: "ivan",
            isOnline: true,
            age: 15,
            files: [UserFile(avatarURL:  "https://img.freepik.com/free-photo/smiley-man-relaxing-outdoors_23-2148739334.jpg")]
        )
    }
}
