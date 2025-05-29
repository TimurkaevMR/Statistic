//
//  StatisticsRealmService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//


import Foundation
import RealmSwift

protocol StatisticsBaseProtocol {
    func retrieveStatistics() async throws -> [UserStatDTO]
    func saveStatistics(_ data: [UserStatDTO]) async throws
}

actor StatisticsRealmService: StatisticsBaseProtocol {
    private let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    func retrieveStatistics() async throws -> [UserStatDTO] {
        try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        ///Warning
                        let statsDTO = Array(realm.objects(UserStatRLM.self))
                            .flatMap({ $0.toDTO() })
                               
                        continuation.resume(returning: statsDTO)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func saveStatistics(_ stats: [UserStatDTO]) async throws {
                
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        let statsRLM = self.mergeStatistics(stats)
                        
                        try realm.write {
                            realm.add(statsRLM, update: .modified)
                        }
                        
                        continuation.resume()
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    
}

private extension StatisticsRealmService {
    
    nonisolated
    func mergeStatistics(_ stats: [UserStatDTO]) -> [UserStatRLM] {
        stats.reduce(into: [Int: UserStatRLM]()) { results, statDTO in
            
            let activity = Activity(userid: statDTO.userId,
                                    type: statDTO.type,
                                    dates: statDTO.dates)
            let defValue = UserStatRLM(userId: statDTO.userId,
                                       activity: [])
            
            let statRLM = results[statDTO.userId, default: defValue]
            statRLM.activity.append(activity)
            results[statDTO.userId] = statRLM
        }
        .values
        .map { statDTO in
            ///Объединяем активности с одинаковым типом
            let groupedActivities = Dictionary(grouping: statDTO.activity, by: { $0.type })
                .map { type, activities in
                    let combinedDates = activities.flatMap { $0.dates }
                    return Activity(userid: statDTO.userId,
                                    type: type,
                                    dates: combinedDates)
                }
            
            statDTO.activity.removeAll()
            statDTO.activity.append(objectsIn: groupedActivities)
            return statDTO
        }
    }
}
