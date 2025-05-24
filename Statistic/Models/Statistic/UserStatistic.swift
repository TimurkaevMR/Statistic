//
//  UserStatistic.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

struct UserStatistic: Decodable {
    let userId: Int
    let type: StatisticType
    let dates: [Int]
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case type, dates
    }
    
    enum StatisticType: String, Decodable {
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
}
