//
//  TagButton.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit

final class TagButton: UIButton {
    var isSelectedTag: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) {
        isHighlighted = false
        setTitle(title, for: .normal)
        titleLabel?.font = .semiBold15()
        titleLabel?.textColor = .ypBlack
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.ypGrayMedium.cgColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        updateAppearance()
        
//        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func updateAppearance() {
        UIView.animate(.default) {
            
            backgroundColor = isSelectedTag ? .ypRed : .ypGrayLight
            layer.borderWidth = isSelectedTag ? 0 : 1
            setTitleColor(isSelectedTag ? .ypWhite : .ypBlack, for: .normal)
        }
    }
    
//    @objc private func buttonTapped() {
//        isSelectedTag = true
//    }
}
