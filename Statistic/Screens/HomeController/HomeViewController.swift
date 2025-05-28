//
//  HomeViewController.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//


import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    
    private lazy var visitorsSection = VisitorsSection()
    private lazy var demographicSection = DemographicSection()
    private lazy var subscribersSection = SubscribersSection()
    private lazy var frequentVisitorsSection = FrequentVisitorsSection()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    private let vm: HomeViewModelProtocol
    private let bag = DisposeBag()
    
    init(vm: HomeViewModelProtocol) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        vm.loadData()
    }
    
    private func setupData() {
        visitorsSection.setupData(vm.dailyVisits)
        frequentVisitorsSection.configure(with: self.vm.frequentVisitors)
        demographicSection.setupData(vm.demographicStats)
        subscribersSection.setupSubscriptionData(vm.subscribers)
        subscribersSection.setupUnsubscriptionData(vm.unsubscribers)
    }
    
    private func bindViewModel() {
        vm.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let self else { return }
                
                isLoading ? self.loadingView.startAnimating() : self.loadingView.stopAnimating()
                
                if isLoading == false {
                    self.setupData()
                }
            })
            .disposed(by: bag)
        
        vm.errorOccurred
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let self else { return }

                self.showErrorAlert(message: error.message)
            })
            .disposed(by: bag)
        
        ///Todo: remove if not needed
//        vm.usersVM.users
//            .subscribe(onNext: { [weak self] users in
//                guard let self else { return }
//
//                self.frequentVisitorsSection.configure(with: users)
//                print("Получены Users: \(users)")
//            })
//            .disposed(by: bag)
//        
//        vm.statisticsVM.statistics
//            .subscribe(onNext: { statistics in
//                print("Получены Statistics: \(statistics)")
//            })
//            .disposed(by: bag)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .ypGrayLight
        setupNavigationTitle()
        setupScrollView()
        setupVisitorsSection()
        setupFrequentVisitorsSection()
        setupDemographicSection()
        setupSubscribersSection()
    }
}

private extension HomeViewController {
    func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Статистика"
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupVisitorsSection() {
        contentView.addSubview(visitorsSection)
        
        NSLayoutConstraint.activate([
            visitorsSection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            visitorsSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .defaultMargin),
            visitorsSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.defaultMargin)
        ])

    }
    
    func setupFrequentVisitorsSection() {
        contentView.addSubview(frequentVisitorsSection)
        
        NSLayoutConstraint.activate([
            frequentVisitorsSection.topAnchor.constraint(equalTo: visitorsSection.bottomAnchor, constant: .mediumMargin),
            frequentVisitorsSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .defaultMargin),
            frequentVisitorsSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.defaultMargin),
        ])
    }
    
    func setupDemographicSection() {
        contentView.addSubview(demographicSection)
        
        NSLayoutConstraint.activate([
            demographicSection.topAnchor.constraint(equalTo: frequentVisitorsSection.bottomAnchor, constant: .mediumMargin),
            demographicSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.defaultMargin),
            demographicSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .defaultMargin),
        ])
    }
    
    func setupSubscribersSection() {
        contentView.addSubview(subscribersSection)
        
        NSLayoutConstraint.activate([
            subscribersSection.topAnchor.constraint(equalTo: demographicSection.bottomAnchor, constant: .mediumMargin),
            subscribersSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.defaultMargin),
            subscribersSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .defaultMargin),
            subscribersSection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -68)
        ])
    }
}
