//
//  UserStatDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 28.05.2025.
//

import Foundation

struct UserStatDTO: Decodable {
    let userId: Int
    let type: StatisticType
    let dates: [Int]
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case type, dates
    }
}
