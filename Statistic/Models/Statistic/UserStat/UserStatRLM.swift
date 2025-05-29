//
//  UserStatRealm.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation
import RealmSwift

///Todo make RLM non Decodable
final class UserStatRLM: Object {
    @Persisted(primaryKey: true) var userId: Int
    @Persisted var activity: List<Activity>
    
    convenience init(userId: Int, activity: [Activity]) {
        self.init()
        self.userId = userId
        self.activity.append(objectsIn: activity)
    }
    override required init() {
        super.init()
    }
}

extension UserStatRLM {
    func toDTO() -> [UserStatDTO] {
        activity.map({
            UserStatDTO(userId: $0.userid,
                        type: $0.type,
                        dates: Array($0.dates))
        })
    }
}

final class Activity: Object {
    @Persisted(primaryKey: true) var userid: Int
    @Persisted var type: StatisticType
    @Persisted var dates: List<Int>
    
    override required init() {
        super.init()
    }
    
    convenience init(userid: Int,
                     type: StatisticType,
                     dates: [Int]) {
        self.init()
        self.userid = userid
        self.type = type
        self.dates.append(objectsIn: dates)
    }
}
