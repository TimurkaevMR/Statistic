//
//  CustomTitleLabel.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import UIKit

final class CustomTitleLabel: UILabel {
    init(text: String = "") {
        super.init(frame: .zero)
        self.text = text
        self.font = .bold20()
        self.textColor = .statBlack
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
