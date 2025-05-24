//
//  ServiceError.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

enum ServiceError: Error {
    case operation(_ type: OperationType,
                   code: String = "uknown")
    
    var message: String {
        switch self {
            
        case .operation(let type, let code):
            "Task \(type.rawValue) operation failed. Error: \(code)"
        }
    }
    
    enum OperationType: String {
        case insertion
        case retrieve
        case deletion
        case update
        case decode
    }
}
