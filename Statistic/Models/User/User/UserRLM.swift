////
////  UserRLM.swift
////  Statistic
////
////  Created by Malik Timurkaev on 24.05.2025.
////
//
//import Foundation
//import RealmSwift
//
//final class UserRLM: Object, Decodable {
//    @Persisted(primaryKey: true) var id: Int
//    @Persisted var sex: Sex
//    @Persisted var username: String
//    @Persisted var isOnline: Bool
//    @Persisted var age: Int
//    @Persisted var files: List<UserFileRLM>
//    
//    enum CodingKeys: String, CodingKey {
//        case id, sex, username, isOnline, age, files
//    }
//    
//    convenience init(id: Int, sex: Sex, username: String, isOnline: Bool, age: Int, files: [UserFileRLM]) {
//        self.init()
//        self.id = id
//        self.sex = sex
//        self.username = username
//        self.isOnline = isOnline
//        self.age = age
//        self.files.append(objectsIn: files)
//    }
//    
//    required convenience init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let id = try container.decode(Int.self, forKey: .id)
//        let sex = try container.decode(Sex.self, forKey: .sex)
//        let username = try container.decode(String.self, forKey: .username)
//        let isOnline = try container.decode(Bool.self, forKey: .isOnline)
//        let age = try container.decode(Int.self, forKey: .age)
//        let files = try container.decode([UserFileRLM].self, forKey: .files)
//        
//        self.init(id: id, sex: sex, username: username, isOnline: isOnline, age: age, files: files)
//    }
//}
//
//extension UserRLM {
//    func toDTO() -> UserDTO {
//        return UserDTO(
//            id: id,
//            sex: sex,
//            username: username,
//            isOnline: isOnline,
//            age: age,
//            files: files.map { $0.toDTO() }
//        )
//    }
//}
