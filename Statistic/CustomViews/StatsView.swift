//
//  StatsView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit
import DGCharts

class StatsView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .ypWhite
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let chartView: LineChartView = {
        let chart = LineChartView()
        chart.backgroundColor = .clear
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .bold20()
        label.textColor = .ypBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .medium15()
        label.textColor = .ypGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        configureChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(chartView)
        
        let rightContainer = UIView()
        rightContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(rightContainer)
        
        rightContainer.addSubview(valueLabel)
        rightContainer.addSubview(descriptionLabel)
        rightContainer.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 98),
            
            chartView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            chartView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
            chartView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -23),
            chartView.widthAnchor.constraint(equalToConstant: 95),
            
            rightContainer.leadingAnchor.constraint(equalTo: chartView.trailingAnchor),
            rightContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rightContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            rightContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant: 20),
            valueLabel.topAnchor.constraint(equalTo: rightContainer.topAnchor, constant: 16),
            valueLabel.heightAnchor.constraint(equalToConstant: 25),
            
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor, constant: -20),
            
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
    
    func setData(values: [Double]) {
        guard !values.isEmpty else { return }

        let isPositive = values.last ?? 0 >= values.first ?? 0
        let lineColor: UIColor = isPositive ? .ypGreen : .ypPurple
        
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
        
        let trendText = isPositive ? "выросло" : "упало"
        descriptionLabel.text = "Количество посетителей в этом месяце \(trendText)"
    }
}
