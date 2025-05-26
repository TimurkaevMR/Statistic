//
//  UserCell.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit

final class UserCell: UITableViewCell {
    static let reuseIdentifier = "UserCell"
    
    let avatarImageView = AvatarImageView()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)
        
        nameLabel.font = .semiBold15()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 62),
            
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with user: User) {
        ///Todo load image
//        avatarImageView.image = UIImage(named: user.avatarName)
        avatarImageView.isOnline = user.isOnline
        nameLabel.text = "\(user.username), \(user.age)"
    }
}
