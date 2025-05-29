//
//  Activity.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation
internal import RealmSwift

final class Activity: Object {
    @Persisted(primaryKey: true) var userid: UUID
    @Persisted var type: StatisticType
    @Persisted var dates: List<Int>
    
    override required init() {
        super.init()
    }
    
    convenience init(userid: UUID = UUID(),
                     type: StatisticType,
                     dates: [Int]) {
        self.init()
        self.userid = userid
        self.type = type
        self.dates.append(objectsIn: dates)
    }
}
