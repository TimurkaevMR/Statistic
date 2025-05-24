//
//  UserFile.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

final class UserFile: Codable, Identifiable {
    let avatarURL: URL
    
    enum FileType: String, Codable {
        case avatarURL = "url"
    }
    
    init(avatarURL: URL) {
        self.avatarURL = avatarURL
    }
}
