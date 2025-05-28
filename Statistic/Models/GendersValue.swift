//
//  GendersValue.swift
//  Statistic
//
//  Created by Malik Timurkaev on 28.05.2025.
//

import Foundation

struct GendersValue {
    var male: Int
    var female: Int
}

extension GendersValue {
    mutating func add(_ sex: Sex) {
        if sex == .male {
            male += 1
        } else {
            female += 1
        }
    }
}
