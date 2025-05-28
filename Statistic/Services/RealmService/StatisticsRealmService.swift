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
                        
                        let statsDTO = Array(realm.objects(UserStatRLM.self))
                            .map({ $0.toDTO() })
                                          
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
                        
                        let statsRLM = stats.map({ $0.toRLM() })
                        
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
