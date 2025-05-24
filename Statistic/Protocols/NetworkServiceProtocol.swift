//
//  NetworkServiceProtocol.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(_ path: Path) async throws -> T
}

extension NetworkServiceProtocol {
    func makeRequest(_ method: HttpMethod,
                     for url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
