//
//  ChartDateFormatter.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import Foundation

final class ChartDateFormatter {
    static let shared = ChartDateFormatter()
    private let formatter = DateFormatter()
    
    private init() {
        formatter.dateFormat = "dd.MM"
    }
    
    func string(from date: Date) -> String {
        return formatter.string(from: date)
    }
}
