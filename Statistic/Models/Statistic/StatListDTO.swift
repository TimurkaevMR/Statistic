//
//  StatListDTO.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

struct StatListDTO: Decodable {
    let statistics: [UserStatDTO]
    
//    func toRLM() -> [UserStatRLM] {
//        statistics.map({ $0.toRLM() })
//    }
}
