//
//  UserStatRealm.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

//import Foundation
//import RealmSwift
//
//final class UserStatRLM: Object {
//    @Persisted(primaryKey: true) var userId: Int
//    @Persisted var activity: List<Activity>
//    
//    convenience init(userId: Int, activity: [Activity]) {
//        self.init()
//        self.userId = userId
//        self.activity.append(objectsIn: activity)
//    }
//    override required init() {
//        super.init()
//    }
//}
//
//extension UserStatRLM {
//    func toDTO() -> [UserStatDTO] {
//        activity.map({
//            UserStatDTO(userId: userId,
//                        type: $0.type,
//                        dates: Array($0.dates))
//        })
//    }
//}
