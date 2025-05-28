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
    private let chartView = CustomChartView()

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
        setupChart()
        
        tagsScrollView.addTags(["По дням", "По неделям", "По месяцам"])
        
        monthVisitorsChartView.setData(values: [12.0, 15.0, 18.0, 22.0, 19.0, 25.0, 30.0])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Посетители"
        
        addSubview(titleLabel)
        addSubview(monthVisitorsChartView)
        addSubview(tagsScrollView)
        addSubview(chartView)
        
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
            
            chartView.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: .regularMargin),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 208),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupChart() {
        let chartData = [
            ChartData(value: 10, date: Date()),
            ChartData(value: 20, date: Date().addingTimeInterval(86400)),
            ChartData(value: 22, date: Date().addingTimeInterval(86420)),
            ChartData(value: 15, date: Date().addingTimeInterval(86440)),
            ChartData(value: 12, date: Date().addingTimeInterval(86460)),
            ChartData(value: 14, date: Date().addingTimeInterval(86480)),
            ChartData(value: 30, date: Date().addingTimeInterval(86490)),
        ]
        
        chartView.setChartData(chartData)
    }
}
