//
//  ChartData.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import Foundation

struct ChartData {
    let value: Double
    let date: Date
    
    var formattedDate: String {
        return ChartDateFormatter.shared.string(from: date)
    }
}
