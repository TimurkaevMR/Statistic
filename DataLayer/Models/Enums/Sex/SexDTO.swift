//
//  SexDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

public enum SexDTO: String, Decodable, Sendable {
    case male = "M"
    case female = "W"
    case other = "O"
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = SexDTO(rawValue: rawValue) ?? .other
    }
}
