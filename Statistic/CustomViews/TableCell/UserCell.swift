//
//  UserCell.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit
import DataLayer

final class UserCell: UITableViewCell {
    static let reuseIdentifier = "UserCell"
    
    private let avatarImageView = AvatarImageView()
    private let nameLabel = UILabel()
    private let networkService = ImageNetworkService.shared
    private var currentTask: Task<Void, Error>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentTask?.cancel()
        currentTask = nil
        avatarImageView.setupImage(.avatarPlug)
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
    
    func configure(with user: UserDTO) {
        avatarImageView.isOnline = user.isOnline
        nameLabel.text = "\(user.username), \(user.age)"
        
        guard let imageUrl = user.files.first?.url else { return }
        loadImage(from: imageUrl)
    }
    
    private func loadImage(from url: String) {
        currentTask = Task { [weak self] in
            guard let self, !Task.isCancelled else { return }
            
            do {
                let image = try await networkService.loadImage(from: url)
                
                await MainActor.run {
                    self.avatarImageView.setupImage(image)
                }
            } catch let error as ServiceError {
                guard !error.isCancellationError else { return }
                assertionFailure(error.message)
            }
        }
    }
}
