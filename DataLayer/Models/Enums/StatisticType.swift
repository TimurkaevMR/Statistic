//
//  StatisticType.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation
internal import RealmSwift

enum StatisticType: String, Decodable, PersistableEnum {
    case view = "view"
    case subscription = "subscription"
    case unsubscription = "unsubscription"
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = StatisticType(rawValue: rawValue) ?? .unknown
    }
}
