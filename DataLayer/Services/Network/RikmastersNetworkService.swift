//
//  RikmastersNetworkService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

public protocol NetworkServiceProtocol {
    func retrieveData<T: Decodable>(_ path: EndPoint) async throws -> T
}

public final class RikmastersNetworkService: NetworkServiceProtocol {
    
    private let decoder: JSONDecoder
    private let session: URLSession
    
    public init(session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.session = session
    }
    
    public func retrieveData<T: Decodable>(_ endPoint: EndPoint) async throws -> T {
        
        guard let url = endPoint.url else {
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
            throw ServiceError.operation(.decode,
                                         code: "\(error.code)")
        }
    }
    
    private func makeRequest(_ method: HttpMethod,
                     for url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
