//
//  UsersRealmService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation
internal import RealmSwift

public protocol UsersBaseProtocol {
    func retrieveUsers() async throws -> [UserDTO]
    func saveUsers(_ data: [UserDTO]) async throws
}

public actor UsersRealmService: UsersBaseProtocol {
    private let configuration: Realm.Configuration
    
    public init() {
        self.configuration = .defaultConfiguration
    }
    
    public func retrieveUsers() async throws -> [UserDTO] {
        try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        
                        let usersDTO = Array(realm.objects(UserRLM.self)).map({
                            $0.toDTO()
                        })
                        
                        continuation.resume(returning: usersDTO)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    public func saveUsers(_ data: [UserDTO]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    do {
                        let realm = try Realm(configuration: self.configuration)
                        try realm.write {
                            
                            let usersRLM = data.map({ $0.toRLM() })
                            
                            realm.add(usersRLM,
                                      update: .modified)
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
