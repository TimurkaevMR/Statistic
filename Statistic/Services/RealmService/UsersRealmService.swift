//
//  UsersRealmDataService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation
import RealmSwift

protocol UsersBaseProtocol {
    func retrieveUsers() async throws -> [User]
    func saveUsers(_ data: [User]) async throws
}

actor UsersRealmService: UsersBaseProtocol {
    private let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    func retrieveUsers() async throws -> [User] {
        try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        let users = Array(realm.objects(User.self).freeze())
                        
                        continuation.resume(returning: users)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func saveUsers(_ data: [User]) async throws {
        
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
