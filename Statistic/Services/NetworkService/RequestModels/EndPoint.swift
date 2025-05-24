//
//  EndPoint.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

enum EndPoint {
    static let baseURL = "http://test.rikmasters.ru/api"
    
    case path(Path)
    
    var url: URL? {
        switch self {
        case .path(let path):
            URL(string: EndPoint.baseURL + path.rawValue)
        }
    }
}
