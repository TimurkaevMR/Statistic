//
//  GenderPieChartView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit
import DGCharts

final class GenderPieChartView: UIView {
    
    private let pieChartView = PieChartView()
    private let maleLabel = {
        let label = UILabel()
        label.font = .medium13()
        label.textColor = .statBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let femaleLabel = {
        let label = UILabel()
        label.font = .medium13()
        label.textColor = .statBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let maleDot = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    private let femaleDot = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    private let dotSize: CGFloat = 10
    private let borderWidth: CGFloat = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .statWhite
        layer.cornerRadius = 16
        layer.masksToBounds = true
        setupPieChart()
        setupLabelsAndDots()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPieChart() {
        pieChartView.transparentCircleRadiusPercent = 0
        pieChartView.holeRadiusPercent = 0.90
        pieChartView.rotationEnabled = false
        pieChartView.highlightPerTapEnabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.drawCenterTextEnabled = false
        pieChartView.legend.enabled = false
        pieChartView.layer.cornerRadius = 10
        pieChartView.layer.masksToBounds = true
        
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pieChartView)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 228),
            
            pieChartView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            pieChartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pieChartView.heightAnchor.constraint(equalToConstant: 152),
            pieChartView.widthAnchor.constraint(equalToConstant: 152)
        ])
    }
    
    private func setupLabelsAndDots() {
        maleDot.backgroundColor = .statRed
        maleDot.layer.cornerRadius = dotSize / 2
        femaleDot.backgroundColor = .statOrange
        femaleDot.layer.cornerRadius = dotSize / 2
        
        addSubview(maleDot)
        addSubview(maleLabel)
        addSubview(femaleDot)
        addSubview(femaleLabel)
        
        NSLayoutConstraint.activate([
            maleDot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            maleDot.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            maleDot.widthAnchor.constraint(equalToConstant: dotSize),
            maleDot.heightAnchor.constraint(equalToConstant: dotSize),
            
            maleLabel.leadingAnchor.constraint(equalTo: maleDot.trailingAnchor, constant: 6),
            maleLabel.centerYAnchor.constraint(equalTo: maleDot.centerYAnchor),
            
            femaleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            femaleLabel.centerYAnchor.constraint(equalTo: maleDot.centerYAnchor),
            
            femaleDot.trailingAnchor.constraint(equalTo: femaleLabel.leadingAnchor, constant: -6),
            femaleDot.centerYAnchor.constraint(equalTo: maleDot.centerYAnchor),
            femaleDot.widthAnchor.constraint(equalToConstant: dotSize),
            femaleDot.heightAnchor.constraint(equalToConstant: dotSize),
        ])
    }
    
    func setData(malePercentage: Double, femalePercentage: Double) {
        let entries = [
            PieChartDataEntry(value: malePercentage, label: ""),
            PieChartDataEntry(value: femalePercentage, label: "")
        ]
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        dataSet.colors = [.statRed, .statOrange]
        
        dataSet.drawValuesEnabled = false
        dataSet.sliceSpace = 4
        dataSet.selectionShift = 0

        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.4
        dataSet.valueLineWidth = borderWidth
        
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.data = data
        maleLabel.text = "Мужчины \(Int(malePercentage))%"
        femaleLabel.text = "Женщины \(Int(femalePercentage))%"
    }
}
