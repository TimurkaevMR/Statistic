//
//  NetworkServiceProtocol.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func retrieveData<T: Decodable>(_ path: Path) async throws -> T
}
