//
//  DemographicSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit

final class DemographicSection: UIView {
    
    private let titleLabel = CustomTitleLabel()
    private let tagsScrollView = TagsScrollView()
    private let pieGenderChart = GenderPieChartView()
    private let separator = UIView()
    private let demographicStats = DemographicStats()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
        setupData()
        tagsScrollView.addTags(["Сегодня", "Неделя", "Месяц", "Все время"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Пол и возраст"
        pieGenderChart.setData(malePercentage: 65, femalePercentage: 35)
        
        separator.backgroundColor = .ypGrayLight
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(tagsScrollView)
        addSubview(pieGenderChart)
        addSubview(separator)
        addSubview(demographicStats)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            tagsScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -.defaultMargin),
            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultMargin),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 32),
            
            pieGenderChart.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: 12),
            pieGenderChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            pieGenderChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            separator.topAnchor.constraint(equalTo: pieGenderChart.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            demographicStats.topAnchor.constraint(equalTo: separator.bottomAnchor),
            demographicStats.leadingAnchor.constraint(equalTo: leadingAnchor),
            demographicStats.trailingAnchor.constraint(equalTo: trailingAnchor),
            demographicStats.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
      
        pieGenderChart.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        demographicStats.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        demographicStats.layer.cornerRadius = .regularRadius
    }
    
    private func setupData() {

        let ages: [String] =
        ["18-21", "22-25", "26-30", "31-35",
         "36-40", "40-50", ">50"]
        
        let data: [GendersValue] =
        [GendersValue(male: 35, female: 35),
         GendersValue(male: 85, female: 75),
         GendersValue(male: 25, female: 15),
         GendersValue(male: 45, female: 55),
         GendersValue(male: 30, female: 20),
         GendersValue(male: -100, female: 0),
         GendersValue(male: 200, female: 200)]
        
        
        let statViews = ages.enumerated().map({ index, age in
            let chartView = DemographicChartView(age: age)
            
            if index <= data.count - 1 {
                chartView.configure(malePercentage: data[index].male, femalePercentage: data[index].female)
            }
            
            return chartView
        })
        
        demographicStats.addStatViews(statViews)
    }
    
    struct GendersValue {
        let male: Double
        let female: Double
    }
}
