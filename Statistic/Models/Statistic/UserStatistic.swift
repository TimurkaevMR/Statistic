//
//  UserStatistic.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation
import RealmSwift

final class UserStatistic: Object, Decodable {
    @Persisted(primaryKey: true) var userId: Int
    @Persisted var type: StatisticType
    @Persisted var dates: List<Int>
    
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
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case type, dates
    }
    
    convenience init(userId: Int, type: StatisticType, dates: [Int]) {
        self.init()
        self.userId = userId
        self.type = type
        self.dates.append(objectsIn: dates)
    }
    
    required convenience init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userId = try container.decode(Int.self, forKey: .userId)
        let type = try container.decode(StatisticType.self, forKey: .type)
        let dates = try container.decode([Int].self, forKey: .dates)
        
        self.init(userId: userId, type: type, dates: dates)
    }
}
