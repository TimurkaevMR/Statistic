//
//  Grade.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

public enum Grade: String, CaseIterable {
    case firstGrade = "21<"
    case secondGrade = "22-25"
    case thirdGrade = "26-30"
    case forthGrade = "31-35"
    case fifthGrade = "36-40"
    case sixthGrade = "41-50"
    case seventhGrade = ">50"
}

extension Grade {
    static func from(age: Int) -> Grade {
        switch age {
        case ..<22: return .firstGrade
        case 22...25: return .secondGrade
        case 26...30: return .thirdGrade
        case 31...35: return .forthGrade
        case 36...40: return .fifthGrade
        case 41...50: return .sixthGrade
        default: return .seventhGrade
        }
    }
}
