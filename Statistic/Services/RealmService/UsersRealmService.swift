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
