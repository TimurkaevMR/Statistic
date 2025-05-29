//
//  GendersValue 2.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

public struct GendersValue {
    public var male: Int
    public var female: Int
    
    public init(male: Int, female: Int) {
        self.male = male
        self.female = female
    }
}

extension GendersValue {
    mutating func add(_ sex: SexDTO) {
        if sex == .male {
            male += 1
        } else {
            female += 1
        }
    }
}
