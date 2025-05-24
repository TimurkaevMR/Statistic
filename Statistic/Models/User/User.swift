//
//  User.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation
import RealmSwift

final class User: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var sex: Sex
    @Persisted var username: String
    @Persisted var isOnline: Bool
    @Persisted var age: Int
    @Persisted var files: List<UserFile>
    
    enum Sex: String, Decodable, PersistableEnum {
        case male = "M"
        case female = "W"
        case other = "O"
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = Sex(rawValue: rawValue) ?? .other
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, sex, username, isOnline, age, files
    }
    
    convenience init(id: Int, sex: Sex, username: String, isOnline: Bool, age: Int, files: [UserFile]) {
        self.init()
        self.id = id
        self.sex = sex
        self.username = username
        self.isOnline = isOnline
        self.age = age
        self.files.append(objectsIn: files)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let sex = try container.decode(Sex.self, forKey: .sex)
        let username = try container.decode(String.self, forKey: .username)
        let isOnline = try container.decode(Bool.self, forKey: .isOnline)
        let age = try container.decode(Int.self, forKey: .age)
        let files = try container.decode([UserFile].self, forKey: .files)
        
        self.init(id: id, sex: sex, username: username, isOnline: isOnline, age: age, files: files)
    }
}

// MARK: - Mock Data
extension User {
    static var mock: User {
        let url = "https://img.freepik.com/free-photo/smiley-man-relaxing-outdoors_23-2148739334.jpg"
        
        return User(
            id: 1,
            sex: .male,
            username: "ivan",
            isOnline: true,
            age: 15,
            files: [
                UserFile(id: 1,
                         url: url,
                         type: "avatar")
            ]
        )
    }
}
