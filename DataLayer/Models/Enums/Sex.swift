//
//  Sex.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation
internal import RealmSwift

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
