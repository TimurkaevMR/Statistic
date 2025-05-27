//
//  SubscribersSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 27.05.2025.
//

import UIKit

final class SubscribersSection: UIView {
    
    private let titleLabel = CustomTitleLabel()
    private let separator = UIView()
    
    private let subscribedChart = {
        let positiveText = "Новые наблюдатели в этом месяце"
        let negativeText = "Пользователей отписались от Вас"
        
        let view = StatsView(trendText: .init(positive: positiveText, negative: negativeText))
        
        view.layer.cornerRadius = .regularRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let unsubscribedChart = {
        let positiveText = "Новые наблюдатели в этом месяце"
        let negativeText = "Пользователей отписались от Вас"
        
        let view = StatsView(trendText: .init(positive: positiveText, negative: negativeText))
        
        view.layer.cornerRadius = .regularRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Пол и возраст"
        
        separator.backgroundColor = .ypGrayLight
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(subscribedChart)
        addSubview(separator)
        addSubview(unsubscribedChart)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subscribedChart.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .regularMargin),
            subscribedChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            subscribedChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            separator.topAnchor.constraint(equalTo: subscribedChart.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            unsubscribedChart.topAnchor.constraint(equalTo: separator.bottomAnchor),
            unsubscribedChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            unsubscribedChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            unsubscribedChart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        subscribedChart.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        unsubscribedChart.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        subscribedChart.layer.cornerRadius = .regularRadius
        unsubscribedChart.layer.cornerRadius = .regularRadius
    }
    
    private func setupData() {
        subscribedChart.setData(values: [12.0, 15.0, 18.0, -22.0, -19.0, 25.0, 30.0])
        unsubscribedChart.setData(values: [-12.0, 15.0, 18.0, 22.0, -19.0, -25.0, -30.0])
    }
}
