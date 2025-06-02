//
//  AgeGenderProgressView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit

final class DemographicChartView: UIView {
    
    private let gradeLabel = {
        let label = UILabel()
        label.font = .semiBold15()
        label.textColor = .statBlack
        return label
    }()
    
    private let maleChartView = HorizontalProgressView(color: .statRed)
    private let femaleChartView = HorizontalProgressView(color: .statOrange)
    
    init(grade: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        gradeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gradeLabel.text = grade
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
        addSubview(gradeLabel)
        addSubview(maleChartView)
        addSubview(femaleChartView)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 28),
            
            gradeLabel.widthAnchor.constraint(equalToConstant: 48),
            gradeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            maleChartView.leadingAnchor.constraint(equalTo: gradeLabel.trailingAnchor, constant: 26),
            maleChartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            maleChartView.centerYAnchor.constraint(equalTo: gradeLabel.centerYAnchor, constant: -6),
            
            femaleChartView.leadingAnchor.constraint(equalTo: gradeLabel.trailingAnchor, constant: 26),
            femaleChartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            femaleChartView.centerYAnchor.constraint(equalTo: gradeLabel.centerYAnchor, constant: 6),
        ])
    }
}
