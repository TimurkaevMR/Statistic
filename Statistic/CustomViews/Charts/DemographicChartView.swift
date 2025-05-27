//
//  AgeGenderProgressView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit

final class DemographicChartView: UIView {
    
    private let ageLabel = {
        let label = UILabel()
        label.font = .semiBold15()
        label.textColor = .ypBlack
        return label
    }()
    
    private let maleChartView = HorizontalProgressView(color: .ypRed)
    private let femaleChartView = HorizontalProgressView(color: .ypOrange)
    
    init(age: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            heightAnchor.constraint(equalToConstant: 28),
            
            ageLabel.widthAnchor.constraint(equalToConstant: 48),
            ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            maleChartView.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 26),
            maleChartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            maleChartView.centerYAnchor.constraint(equalTo: ageLabel.centerYAnchor, constant: -6),
            
            femaleChartView.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 26),
            femaleChartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            femaleChartView.centerYAnchor.constraint(equalTo: ageLabel.centerYAnchor, constant: 6),
        ])
    }
}
