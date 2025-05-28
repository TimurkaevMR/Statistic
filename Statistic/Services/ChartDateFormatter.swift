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
    
    /// Форматирует Date в строку "dd.MM" (например, "12.01").
    func string(from date: Date) -> String {
        return formatter.string(from: date)
    }
    
    /// Конвертирует Unix-время (timestamp в секундах) в строку "dd.MM".
    func string(fromTimestamp timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        return string(from: date)
    }
    
    /// Конвертирует Unix-время (timestamp в секундах) в строку с кастомным форматом.
    /// Пример: `format(timestamp: 1092024, format: "dd MMMM yyyy, HH:mm:ss")` → "12 января 1970, 15:20:24".
    func format(
        timestamp: TimeInterval,
        format: String,
        locale: Locale = Locale(identifier: "ru_RU"),
        timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
    ) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let customFormatter = DateFormatter()
        customFormatter.dateFormat = format
        customFormatter.locale = locale
        customFormatter.timeZone = timeZone
        return customFormatter.string(from: date)
    }
}
