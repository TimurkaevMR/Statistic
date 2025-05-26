//
//  VisitorsSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import UIKit

final class VisitorsSection: UIView {
    
    private let titleLabel = CustomTitleLabel()

    private let statsView = {
        let view = StatsView()
        view.layer.cornerRadius = .regularRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Посетители"
        
        addSubview(titleLabel)
        addSubview(statsView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            statsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            statsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        ///Todo: remove mock
        statsView.setData(values: [12.0, 15.0, 18.0, -22.0, -19.0, 25.0, 30.0])
    }
}
