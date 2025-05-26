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
    private let genderChart = GenderPieChartView()
    let progressView = GenderAgeChartView(age: "18-21")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        tagsScrollView.addTags(["Сегодня", "Неделя", "Месяц", "Все время"])
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Пол и возраст"
        genderChart.setData(malePercentage: 65, femalePercentage: 35)
        
        
        addSubview(titleLabel)
        addSubview(tagsScrollView)
        addSubview(genderChart)
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//        
//            tagsScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
//            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -.defaultMargin),
//            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultMargin),
//            tagsScrollView.heightAnchor.constraint(equalToConstant: 32),
//            
//            genderChart.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: 12),
//            genderChart.leadingAnchor.constraint(equalTo: leadingAnchor),
//            genderChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        progressView.configure(malePercentage: 65, femalePercentage: 35)
    }
}
