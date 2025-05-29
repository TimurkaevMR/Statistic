//
//  DemographicSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit
import DataLayer

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
        tagsScrollView.addTags(["Сегодня", "Неделя", "Месяц", "Все время"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(_ stats: [Grade: GendersValue]) {
        setupPieGenderChartStats(stats)
        setupDemographicStats(stats)
    }
    
    private func setupUI() {
        titleLabel.text = "Пол и возраст"
        
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
        
            tagsScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .regularMargin),
            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -.defaultMargin),
            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultMargin),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 32),
            
            pieGenderChart.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: .regularMargin),
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
}

private extension DemographicSection {
    func setupPieGenderChartStats(_ stats: [Grade: GendersValue]) {
        let peopleAmount: Int = peopleAmount(stats.values)

        let maleAmount: Int = stats.values.reduce(0) { partialResult, gender in
            partialResult + gender.male
        }
        
        let femaleAmount: Int = stats.values.reduce(0) { partialResult, gender in
            partialResult + gender.female
        }
        
        ///Защита от деления на ноль и отрицательных значений
        guard peopleAmount > 0, maleAmount >= 0, femaleAmount >= 0 else {
            pieGenderChart.setData(malePercentage: 0, femalePercentage: 0)
            return
        }
        
        let malePercentage = Double(maleAmount) / Double(peopleAmount) * 100
        let femalePercentage = Double(femaleAmount) / Double(peopleAmount) * 100
        
        ///Проверка на валидность процентов (должны суммироваться ~100%)
        let total = malePercentage + femalePercentage
        guard !total.isNaN, total > 0 else {
            pieGenderChart.setData(malePercentage: 0, femalePercentage: 0)
            return
        }
        
        pieGenderChart.setData(
            malePercentage: malePercentage,
            femalePercentage: femalePercentage
        )
    }
    
    func setupDemographicStats(_ stats: [Grade: GendersValue]) {
        let peopleAmount = peopleAmount(stats.values)
        
        ///Создаем словарь со всеми возможными группами, включая отсутствующие
        var allGroupsStats = [Grade: GendersValue]()
        
        ///Инициализируем все группы (даже с нулевыми значениями)
        Grade.allCases.forEach { grade in
            allGroupsStats[grade] = stats[grade, default: GendersValue(male: 0, female: 0)]
        }
        
        ///Сортируем группы по убыванию общего количества людей
        let sortedGroups = allGroupsStats.sorted {
            ($0.key.rawValue) < ($1.key.rawValue)
        }
        
        ///Создаем view для каждой группы
        let statViews = sortedGroups.map { grade, genderValue in
            let chartView = DemographicChartView(grade: grade.rawValue)
            
            let malePercentage = peopleAmount > 0 ?
                Double(genderValue.male) / Double(peopleAmount) * 100 : 0
            let femalePercentage = peopleAmount > 0 ?
                Double(genderValue.female) / Double(peopleAmount) * 100 : 0
            
            chartView.configure(
                malePercentage: malePercentage,
                femalePercentage: femalePercentage
            )
            
            return chartView
        }
        
        demographicStats.addStatViews(statViews)
    }
    
    func peopleAmount(_ values: [Grade: GendersValue].Values) -> Int {
        return values.reduce(0) { partialResult, gender in
            partialResult + (gender.male + gender.female)
        }
    }
}
