//
//  CustomChartView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit
import DGCharts

class CustomChartView: UIView {
    private let chartView = LineChartView()
    private let horizontalLineImageView = UIImageView()
    private let middleLineImageView = UIImageView()
    private let topLineImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        setupChart()
        setupHorizontalLines()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupChart()
        setupHorizontalLines()
    }
    
    private func setupView() {
        backgroundColor = .ypWhite
        layer.cornerRadius = .regularRadius
        layer.masksToBounds = true
        
        [chartView, horizontalLineImageView,
         middleLineImageView, topLineImageView].forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        let lineTopSpacing: CGFloat = -74
        let trailingPadding: CGFloat = -32
        let leftPadding: CGFloat = 14
        
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartView.topAnchor.constraint(equalTo: topAnchor),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            horizontalLineImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftPadding),
            horizontalLineImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingPadding),
            horizontalLineImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: trailingPadding),
            horizontalLineImageView.heightAnchor.constraint(equalToConstant: 1),
            
            middleLineImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftPadding),
            middleLineImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingPadding),
            middleLineImageView.bottomAnchor.constraint(equalTo: horizontalLineImageView.topAnchor, constant: lineTopSpacing),
            middleLineImageView.heightAnchor.constraint(equalToConstant: 1),
            
            topLineImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftPadding),
            topLineImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingPadding),
            topLineImageView.bottomAnchor.constraint(equalTo: middleLineImageView.topAnchor, constant: lineTopSpacing),
            topLineImageView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupChart() {
        chartView.extraLeftOffset = 32
        chartView.extraRightOffset = 32
        
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(false)
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .ypGrayDark
        xAxis.labelFont = .medium11()
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        xAxis.drawAxisLineEnabled = false
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.drawMarkers = true
    }
    
    private func setupHorizontalLines() {
        let lineImage: UIImage = .dottedLine
        horizontalLineImageView.image = lineImage
        middleLineImageView.image = lineImage
        topLineImageView.image = lineImage
    }
    
    func setChartData(_ data: [ChartData]) {
        var entries = [ChartDataEntry]()
        for (index, element) in data.enumerated() {
            entries.append(ChartDataEntry(x: Double(index), y: element.value))
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.colors = [.ypRed]
        dataSet.lineWidth = 3
        dataSet.drawCirclesEnabled = true
        dataSet.circleColors = [.ypRed]
        dataSet.circleRadius = 6
        dataSet.circleHoleRadius = 3
        dataSet.drawValuesEnabled = false
        
        chartView.data = LineChartData(dataSet: dataSet)
        
        if let formatter = chartView.xAxis.valueFormatter as? Self {
            formatter.dates = data.map { $0.formattedDate }
        }
        
        chartView.notifyDataSetChanged()
    }
}

extension CustomChartView: AxisValueFormatter {
    private struct Holder {
        static var dates: [String] = []
    }
    
    var dates: [String] {
        get { Holder.dates }
        set { Holder.dates = newValue }
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard index >= 0, index < dates.count else { return "" }
        return dates[index]
    }
}
