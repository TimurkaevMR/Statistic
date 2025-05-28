//
//  UserFileDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 28.05.2025.
//

import Foundation

struct UserFileDTO: Decodable {
    let id: Int
    let url: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, url, type
    }
    
    func toRealm() -> UserFile {
        return UserFile(
            id: id,
            url: url,
            type: type
        )
    }
}
