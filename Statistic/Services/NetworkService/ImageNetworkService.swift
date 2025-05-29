//
//  ImageNetworkService.swift
//  Statistic
//
//  Created by Malik Timurkaev on 28.05.2025.
//

//import UIKit
//
//protocol ImageNetworkProtocol {
//    func loadImage(from url: String) async throws -> UIImage
//}
//
//actor ImageNetworkService: ImageNetworkProtocol {
//    static let shared = ImageNetworkService()
//    
//    private typealias urlString = String
//    private var cache: [urlString: UIImage] = [:]
//    
//    private let decoder = JSONDecoder()
//    private let session = URLSession.shared
//    
//    private init() {}
//    
//    func loadImage(from urlString: String) async throws -> UIImage {
//        
//        if let image = cache[urlString] {
//            return image
//        }
//        
//        guard let url = URL(string: urlString) else {
//            throw ServiceError.operation(.retrieve)
//        }
//        
//        let request = makeRequest(.get, for: url)
//        
//        let (data, response) = try await session.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw ServiceError.operation(.retrieve,
//                                         code: "0")
//        }
//        
//        guard (200...299).contains(httpResponse.statusCode) else {
//            throw ServiceError.operation(.retrieve,
//                                         code: "\(httpResponse.statusCode)")
//        }
//        
//        if let image = UIImage(data: data) {
//            cache[urlString] = cache[urlString, default: image]
//            return image
//        } else {
//            throw ServiceError.operation(.decode)
//        }
//    }
//    
//    private func makeRequest(_ method: HttpMethod,
//                     for url: URL) -> URLRequest {
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        
//        return request
//    }
//}
