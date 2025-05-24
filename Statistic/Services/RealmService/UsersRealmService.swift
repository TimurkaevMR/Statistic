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

protocol StatisticsBaseProtocol {
    func retrieveStatistics() async throws -> [UserStatistic]
    func saveStatistics(_ data: [UserStatistic]) async throws
}

actor UsersRealmService: UsersBaseProtocol {
    private let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    private func getRealm() throws -> Realm {
        try Realm(configuration: configuration)
    }
    
    func retrieveUsers() async throws -> [User] {
        let realm = try getRealm()
        return Array(realm.objects(User.self).freeze())
    }
    
    func saveUsers(_ data: [User]) async throws {
        let realm = try getRealm()
        try await realm.asyncWrite {
            realm.add(data, update: .modified)
        }
    }
}


//protocol DataBaseProtocol {
//    func retrieveData<T: Object>() async throws -> [T]
//    func save<T: Object>(_ object: T) async throws
//}
//
//actor RealmService: DataBaseProtocol {
//    private let configuration: Realm.Configuration
//    
//    init(configuration: Realm.Configuration = .defaultConfiguration) {
//        self.configuration = configuration
//    }
//    
//    private func getRealm() throws -> Realm {
//        try Realm(configuration: configuration)
//    }
//    
//    func retrieveData<T: Object>() async throws -> [T] {
//        let realm = try getRealm()
//        return Array(realm.objects(T.self).freeze())
//    }
//    
//    func save<T: Object>(_ object: T) async throws {
//        let realm = try getRealm()
//        try await realm.asyncWrite {
//            realm.add(object, update: .modified)
//        }
//    }
//}
