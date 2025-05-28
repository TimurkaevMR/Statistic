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
    private let activityTrendChartView = ActivityTrendChartView()
    
    private let monthVisitorsChartView = {
        let positiveText = "Количество посетителей в этом месяце выросло"
        let negativeText = "Количество посетителей в этом месяце убавилось"
        
        let view = StatsView(trendText: .init(positive: positiveText, negative: negativeText))
        
        view.layer.cornerRadius = .regularRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        tagsScrollView.addTags(["По дням", "По неделям", "По месяцам"])
        
        monthVisitorsChartView.setData(values: [12.0, 15.0, 18.0, 22.0, 19.0, 25.0, 30.0])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(_ data: [(date: Int, count: Int)]) {
        monthVisitorsChartView.setData(values:
                                        data.map({ Double($0.count) }))
        
        activityTrendChartView.setChartData(
            data.map({ ChartData(value: Double($0.count),
                                 date: Date(timeIntervalSince1970: TimeInterval($0.date))) })
        )
    }
    
    private func setupUI() {
        titleLabel.text = "Посетители"
        
        addSubview(titleLabel)
        addSubview(monthVisitorsChartView)
        addSubview(tagsScrollView)
        addSubview(activityTrendChartView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            monthVisitorsChartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .regularMargin),
            monthVisitorsChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthVisitorsChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tagsScrollView.topAnchor.constraint(equalTo: monthVisitorsChartView.bottomAnchor, constant: 28),
            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -.defaultMargin),
            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultMargin),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 32),
            
            activityTrendChartView.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: .regularMargin),
            activityTrendChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityTrendChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityTrendChartView.heightAnchor.constraint(equalToConstant: 208),
            activityTrendChartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
