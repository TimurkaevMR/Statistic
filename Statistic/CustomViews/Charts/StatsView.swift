//
//  StatsView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit
import DGCharts

final class StatsView: UIView {
    
    private let chartView: LineChartView = {
        let chart = LineChartView()
        chart.backgroundColor = .clear
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .bold20()
        label.textColor = .statBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .medium15()
        label.textColor = .statGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView = {
        let imageView = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let trendTitle: TrendTitle
    
    init(trendText: TrendTitle = TrendTitle(positive: "", negative: "")) {
        
        self.trendTitle = trendText
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .statWhite
        
        setupUI()
        configureChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(values: [Double]) {
        guard !values.isEmpty else { return }

        let isPositive = values.last ?? 0 >= values.first ?? 0
        let lineColor: UIColor = isPositive ? .statGreen : .statPurple
        
        let entries = values.enumerated().map { index, value in
            ChartDataEntry(x: Double(index), y: value)
        }
        
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.mode = .cubicBezier
        
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.lineWidth = 3
        dataSet.setColor(lineColor)
        
        if let lastEntry = entries.last {
            let circleSet = LineChartDataSet(entries: [lastEntry])
            circleSet.drawCirclesEnabled = true
            circleSet.circleRadius = 6
            circleSet.circleHoleRadius = 3
            circleSet.circleColors = [lineColor]
            circleSet.setColor(.clear)
            
            chartView.data = LineChartData(dataSets: [dataSet, circleSet])
        } else {
            chartView.data = LineChartData(dataSet: dataSet)
        }
        
        chartView.data?.setDrawValues(false)
        
        let lastValue = values.last ?? 0
        
        valueLabel.text = String(format: "%.0f", lastValue)
        arrowImageView.image = isPositive ? .arrowUp : .arrowDown
        
        let trendText = isPositive ? trendTitle.positive : trendTitle.negative
        descriptionLabel.text = trendText
    }
    
    private func setupUI() {
        addSubview(chartView)
        addSubview(valueLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 98),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            chartView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            chartView.widthAnchor.constraint(equalToConstant: 96),
            
            valueLabel.leadingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 20),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            valueLabel.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            arrowImageView.topAnchor.constraint(equalTo: valueLabel.topAnchor, constant: 4),
            arrowImageView.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 2)
        ])
    }
    
    private func configureChart() {
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.autoScaleMinMaxEnabled = true
    }
    
    struct TrendTitle {
        let positive: String
        let negative: String
    }
}
