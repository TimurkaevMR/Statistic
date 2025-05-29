//
//  UsersRealmDataService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

//import Foundation
//import RealmSwift
//
//protocol UsersBaseProtocol {
//    func retrieveUsers() async throws -> [UserDTO]
//    func saveUsers(_ data: [UserDTO]) async throws
//}
//
//actor UsersRealmService: UsersBaseProtocol {
//    private let configuration: Realm.Configuration
//    
//    init(configuration: Realm.Configuration = .defaultConfiguration) {
//        self.configuration = configuration
//    }
//    
//    func retrieveUsers() async throws -> [UserDTO] {
//        try await withCheckedThrowingContinuation { continuation in
//            
//            DispatchQueue.global(qos: .userInitiated).async {
//                autoreleasepool {
//                    
//                    do {
//                        let realm = try Realm(configuration: self.configuration)
//                        
//                        let usersDTO = Array(realm.objects(UserRLM.self)).map({
//                            $0.toDTO()
//                        })
//                        
//                        continuation.resume(returning: usersDTO)
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                }
//            }
//        }
//    }
//    
//    func saveUsers(_ data: [UserDTO]) async throws {
//        try await withCheckedThrowingContinuation { continuation in
//            DispatchQueue.global(qos: .userInitiated).async {
//                autoreleasepool {
//                    do {
//                        let realm = try Realm(configuration: self.configuration)
//                        try realm.write {
//                            
//                            let usersRLM = data.map({ $0.toRLM() })
//                            
//                            realm.add(usersRLM,
//                                      update: .modified)
//                        }
//                        continuation.resume()
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                }
//            }
//        }
//    }
//}
