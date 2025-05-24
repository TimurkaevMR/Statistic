//
//  StatisticsRealmService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//


import Foundation
import RealmSwift

actor StatisticsRealmService: StatisticsBaseProtocol {
    private let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    func retrieveStatistics() async throws -> [UserStatistic] {
        let realm = try getRealm()
        
        return Array(realm.objects(UserStatistic.self).freeze())
    }
    
    func saveStatistics(_ data: [UserStatistic]) async throws {
        let realm = try getRealm()
        try await realm.asyncWrite {
            realm.add(data, update: .modified)
        }
    }
    
    private func getRealm() throws -> Realm {
        try Realm(configuration: configuration)
    }
}
