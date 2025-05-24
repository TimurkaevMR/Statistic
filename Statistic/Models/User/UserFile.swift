//
//  UserFile.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

final class UserFile: Decodable {
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "url"
    }
    
    init(avatarURL: String) {
        self.avatarURL = avatarURL
    }
}
