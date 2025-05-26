//
//  AgeGenderProgressView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit

class GenderAgeChartView: UIView {
    private let ageLabel = {
        let label = UILabel()
        label.font = .semiBold15()
        label.textColor = .ypBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maleChartView = HorizontalProgressView(color: .ypRed)
    private let femaleChartView = HorizontalProgressView(color: .ypOrange)
    
    init(age: String) {
        super.init(frame: .zero)
        ageLabel.text = age
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func configure(malePercentage: Double,
                   femalePercentage: Double) {
                
        maleChartView.setProgress(value: malePercentage)
        femaleChartView.setProgress(value: femalePercentage)
    }
    
    private func setupViews() {
        addSubview(ageLabel)
        addSubview(maleChartView)
        addSubview(femaleChartView)
        
        NSLayoutConstraint.activate([
            ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            maleChartView.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 38),
            maleChartView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            maleChartView.centerYAnchor.constraint(equalTo: ageLabel.centerYAnchor, constant: -6),
            maleChartView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            femaleChartView.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 38),
            femaleChartView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            femaleChartView.centerYAnchor.constraint(equalTo: ageLabel.centerYAnchor, constant: 6),
            femaleChartView.widthAnchor.constraint(equalTo: maleChartView.widthAnchor),
        ])
    }
}
