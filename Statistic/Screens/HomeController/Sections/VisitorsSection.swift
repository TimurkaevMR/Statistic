//
//  VisitorsSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import UIKit

final class VisitorsSection: UIView {
    
    private let titleLabel = CustomTitleLabel()
    private let tagsScrollView = TagsScrollView()
    
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
        
        tagsScrollView.addTags(["По дням", "По неделям", "По месяцам"])
        
        ///Todo: remove mock
        statsView.setData(values: [12.0, 15.0, 18.0, -22.0, -19.0, 25.0, 30.0])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Посетители"
        
        addSubview(titleLabel)
        addSubview(statsView)
        addSubview(tagsScrollView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            statsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            statsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tagsScrollView.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 28),
            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -.defaultMargin),
            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultMargin),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 40),
            tagsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
