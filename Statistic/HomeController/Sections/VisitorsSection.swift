//
//  VisitorsSection.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import UIKit

final class VisitorsSection: UIView {
    
    private let titleLabel = CustomTitleLabel()
    private let tagsScrollView = TagsScrollView()
    private let activityTrendChartView = ActivityTrendChartView()
    
    private let monthVisitorsChartView = {
        let positiveText = "Количество посетителей в этом месяце выросло"
        let negativeText = "Количество посетителей в этом месяце убавилось"
        
        let view = StatsView(trendText: .init(positive: positiveText, negative: negativeText))
        
        view.layer.cornerRadius = .regularRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        tagsScrollView.addTags(["По дням", "По неделям", "По месяцам"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Изза не большого количества данных (у которых к тому же и даты не актуального месяца) мне пришлось писать в методе логику, которая игнорирует месяц и год даты, и сортерует только по дню
    func setupData(_ data: [(date: Int, count: Int)]) {
        ///Преобразуем входные данные в массив ChartData
        let dates = data.map {
            let date = Date(timeIntervalSince1970: TimeInterval($0.date))
            return ChartData(value: Double($0.count), date: date)
        }
        
        ///Сортируем только по дню месяца
        let dayBasedSortion = dates.sorted {
            let calendar = Calendar.current
            let day1 = calendar.component(.day, from: $0.date)
            let day2 = calendar.component(.day, from: $1.date)
            return day1 < day2
        }
        
        monthVisitorsChartView.setData(values: dayBasedSortion.map({ $0.value }))
        activityTrendChartView.setChartData(dayBasedSortion)
    }
    
    private func setupUI() {
        titleLabel.text = "Посетители"
        
        addSubview(titleLabel)
        addSubview(monthVisitorsChartView)
        addSubview(tagsScrollView)
        addSubview(activityTrendChartView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            monthVisitorsChartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .regularMargin),
            monthVisitorsChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthVisitorsChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tagsScrollView.topAnchor.constraint(equalTo: monthVisitorsChartView.bottomAnchor, constant: 28),
            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -.defaultMargin),
            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultMargin),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 32),
            
            activityTrendChartView.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: .regularMargin),
            activityTrendChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityTrendChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityTrendChartView.heightAnchor.constraint(equalToConstant: 208),
            activityTrendChartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
