//
//  ServiceError.swift
//  Statistic
//
//  Created by Malik Timurkaev on 29.05.2025.
//

import Foundation

public enum ServiceError: Error {
    case operation(_ type: ServiceOperation,
                   code: String = "uknown")
    
    public var message: String {
        switch self {
            
        case .operation(let type, let code):
            "Task \(type.rawValue) operation failed. Error: \(code)"
        }
    }
}
