//
//  TagButton.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit

final class TagButton: UIButton {
    private let title: String
    
    var isSelectedTag: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.ypGrayMedium.cgColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        UIView.animate(.default) { [weak self] in
            guard let self else { return }
            
            self.backgroundColor = self.isSelectedTag ? .ypRed : .ypGrayLight
            self.layer.borderWidth = self.isSelectedTag ? 0 : 1
            
            var configuration = UIButton.Configuration.plain()
            let titleColor: UIColor = isSelectedTag ? .ypWhite : .ypBlack
           
            configuration.attributedTitle = AttributedString(
                title,
                attributes: AttributeContainer([
                    .font: UIFont.semiBold15(),
                    .foregroundColor: titleColor
                ])
            )
            self.configuration = configuration
        }
    }
}
