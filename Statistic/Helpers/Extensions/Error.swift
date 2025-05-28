//
//  Error.swift
//  Statistic
//
//  Created by Malik Timurkaev on 28.05.2025.
//

import Foundation

extension Error {
    var isCancellationError: Bool {
        (self as? URLError)?.code == .cancelled ||
        (self as NSError).code == NSURLErrorCancelled
    }
}
