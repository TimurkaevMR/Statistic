//
//  NetworkService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    private let decoder: JSONDecoder
    private let session: URLSession
    
    init(session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.session = session
    }
    
    func fetchData<T: Decodable>(_ path: Path) async throws -> T {
        
        guard let url = EndPoint.path(path).url else {
            throw ServiceError.operation(.retrieve)
        }
        
        let request = makeRequest(.get, for: url)
        
        return try await performRequest(request)
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.operation(.retrieve,
                                         code: "0")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.operation(.retrieve,
                                         code: "\(httpResponse.statusCode)")
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error as NSError {
            throw ServiceError.operation(.retrieve,
                                         code: "\(error.code)")
        }
    }
}
