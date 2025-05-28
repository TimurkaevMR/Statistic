//
//  FrequentVisitorsSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit

final class FrequentVisitorsSection: UIView {
    
    private let titleLabel = CustomTitleLabel()
    private let tableView = UITableView()
    private var users: [UserRLM] = []
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with users: [UserRLM]) {
        self.users = users
        tableView.reloadData()
        heightConstraint?.constant = CGFloat(users.count) * 62
    }
    
    private func setupUI() {
        titleLabel.text = "Чаще всех посещают Ваш профиль"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = .lowRadius
        
        tableView.rowHeight = 62
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .regularMargin),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        heightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
}

extension FrequentVisitorsSection: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell else {
            
            return UITableViewCell()
        }
        
        cell.configure(with: users[indexPath.row])
        cell.separatorInset = setEdgeInsets(for: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension FrequentVisitorsSection {
    func setEdgeInsets(for row: Int) -> UIEdgeInsets {
        if row != users.count - 1 {
            return UIEdgeInsets(top: 0, left: 84, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
    }
}
