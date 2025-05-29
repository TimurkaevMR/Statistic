//
//  EndPoint.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//


import Foundation

enum EndPoint {
    static let baseURL = "http://test.rikmasters.ru/api"
    
    case baseServer(Path)
    
    var url: URL? {
        switch self {
        case .baseServer(let path):
            URL(string: EndPoint.baseURL + path.rawValue)
        }
    }
    
    enum Path: String {
        case users = "/users"
        case statistics = "/statistics"
    }
}

