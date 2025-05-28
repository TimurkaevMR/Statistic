//
//  EndPoint.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

//enum EndPoint {
//    static let baseURL = "http://test.rikmasters.ru/api"
//    
//    case path(Path)
//    case image(_ url: String)
//    
//    var url: URL? {
//        switch self {
//        case .path(let path):
//            URL(string: EndPoint.baseURL + path.rawValue)
//            
//        case .image(let urlString):
//            URL(string: urlString)
//        }
//    }
//}

enum EndPoint {
    static let baseURL = "http://test.rikmasters.ru/api"
    
    case baseServer(Path)
    case image(_ url: String)
    
    var url: URL? {
        switch self {
        case .baseServer(let path):
            URL(string: EndPoint.baseURL + path.rawValue)
            
        case .image(let urlString):
            URL(string: urlString)
        }
    }
    
    enum Path: String {
        case users = "/users"
        case statistics = "/statistics"
    }
}

