//
//  TagsScrollView.swift
//  Statistic
//
//  Created by Malik Timurkaev on 26.05.2025.
//


import UIKit

final class TagsScrollView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var tagButtons: [TagButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .defaultMargin),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -.defaultMargin),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func addTags(_ titles: [String]) {
        titles.forEach { addTag(title: $0) }
        
        if let button = tagButtons.first {
            tagButtonTapped(button)
        }
    }
    
    private func addTag(title: String) {
        let button = TagButton(title: title)
        button.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
        
        tagButtons.append(button)
        stackView.addArrangedSubview(button)
    }
    
    @objc private func tagButtonTapped(_ sender: TagButton) {
        tagButtons.forEach { $0.isSelectedTag = ($0 == sender) }
    }
}
