//
//  DemographicStats.swift
//  Statistic
//
//  Created by Malik Timurkaev on 27.05.2025.
//

import UIKit

final class DemographicStats: UIView {
    
    private let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.alignment = .leading
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addStatViews(_ statViews: [DemographicChartView]) {
            
        statViews.forEach({
            stackView.addArrangedSubview($0)
        })
    }
    
    private func setupUI() {
        addSubview(stackView)
        backgroundColor = .ypWhite
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
