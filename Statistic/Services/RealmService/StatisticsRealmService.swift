//
//  StatisticsRealmService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//


import Foundation
import RealmSwift

protocol StatisticsBaseProtocol {
    func retrieveStatistics() async throws -> [UserStatistic]
    func saveStatistics(_ data: [UserStatistic]) async throws
}

actor StatisticsRealmService: StatisticsBaseProtocol {
    private let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    func retrieveStatistics() async throws -> [UserStatistic] {
        try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        let statistic = Array(realm.objects(UserStatistic.self).freeze())
                                          
                        continuation.resume(returning: statistic)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func saveStatistics(_ data: [UserStatistic]) async throws {
        
        let refs = data.map({ ThreadSafeReference(to: $0)})
        
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        let objects = refs.compactMap({ realm.resolve($0) })
                        
                        try realm.write {
                            realm.add(objects, update: .modified)
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
