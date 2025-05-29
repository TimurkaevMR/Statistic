//
//  UserFileDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

public struct UserFileDTO: Decodable, Sendable {
    let id: Int
    public let url: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, url, type
    }
}

extension UserFileDTO {
    func toRLM() -> UserFileRLM {
        UserFileRLM(
            id: id,
            url: url,
            type: type
        )
    }
}
