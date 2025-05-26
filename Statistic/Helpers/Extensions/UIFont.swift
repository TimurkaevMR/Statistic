//
//  Fonts.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import UIKit

extension UIFont {
    static func customFont(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    static func bold20() -> UIFont {
        return customFont(weight: .bold, size: 20)
    }
    
    static func medium15() -> UIFont {
        return customFont(weight: .medium, size: 15)
    }
}
