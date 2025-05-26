//
//  AvatarImageView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit

final class AvatarImageView: UIView {
    private let onlineIndicator = UIView()
    private let imageView = {
        let image = UIImage(systemName: "person.circle.fill")
        var imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 19
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var isOnline: Bool = false {
        didSet {
            onlineIndicator.isHidden = !isOnline
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        
        onlineIndicator.backgroundColor = .systemGreen
        onlineIndicator.layer.borderColor = UIColor.ypWhite.cgColor
        onlineIndicator.layer.borderWidth = 1
        onlineIndicator.layer.cornerRadius = 4
        onlineIndicator.isHidden = true
        
        addSubview(imageView)
        addSubview(onlineIndicator)
        onlineIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 38),
            widthAnchor.constraint(equalTo: heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 38),
            imageView.widthAnchor.constraint(equalTo: heightAnchor),
            
            onlineIndicator.widthAnchor.constraint(equalToConstant: 8),
            onlineIndicator.heightAnchor.constraint(equalToConstant: 8),
            onlineIndicator.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -1),
            onlineIndicator.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -1)
        ])
    }
}
