//
//  HorizontalProgressView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//

import UIKit

final class HorizontalProgressView: UIView {

    private let progressView = UIView()
    private let percentageLabel = UILabel()
    private var progressWidthConstraint: NSLayoutConstraint?
    
    init(color: UIColor) {
        super.init(frame: .zero)
        progressView.backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setProgress(value: Double) {
        let percentage = max(0, min(100, value))
        let progress = percentage / 100.0
        
        progressWidthConstraint?.isActive = false
        progressWidthConstraint = progressView.widthAnchor.constraint(
            equalTo: widthAnchor,
            multiplier: CGFloat(progress))
        
        progressWidthConstraint?.isActive = true
        percentageLabel.text = "\(Int(round(percentage)))%"
                
        NSLayoutConstraint.activate([
            percentageLabel.leadingAnchor.constraint(
                equalTo: progressView.trailingAnchor,
                constant: 10
            ),
            percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        layoutIfNeeded()
    }
    
    private func setupViews() {
        percentageLabel.font = .medium10()
        percentageLabel.textColor = .ypBlack
        
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 4
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(progressView)
        addSubview(percentageLabel)
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 6),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
