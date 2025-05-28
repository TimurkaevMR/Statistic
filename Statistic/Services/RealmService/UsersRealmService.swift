//
//  UsersRealmDataService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation
import RealmSwift

protocol UsersBaseProtocol {
    func retrieveUsers() async throws -> [UserRLM]
    func saveUsers(_ data: [UserRLM]) async throws
}

actor UsersRealmService: UsersBaseProtocol {
    private let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    func retrieveUsers() async throws -> [UserRLM] {
        try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        let users = Array(realm.objects(UserRLM.self).freeze())
                        
                        continuation.resume(returning: users)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func saveUsers(_ data: [UserRLM]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        try realm.write {
                            
                            realm.add(data, update: .modified)
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
