//
//  HomeViewController.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//


import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    private let bag = DisposeBag()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setupUI()
        bindViewModel()
        viewModel.loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        ///Подписка на загрузку
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.loadingView.startAnimating() : self?.loadingView.stopAnimating()
            })
            .disposed(by: bag)
        
        ///Подписка на ошибки
        viewModel.errorOccurred
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showErrorAlert(message: error.message)
            })
            .disposed(by: bag)
        
        ///Подписка на Users с выводом в консоль
        viewModel.usersViewModel.users
            .subscribe(onNext: { users in
                print("Получены Users: \(users)")
            })
            .disposed(by: bag)
        
        ///Подписка на Statistics с выводом в консоль
        viewModel.statisticsViewModel.statistics
            .subscribe(onNext: { statistics in
                print("Получены Statistics: \(statistics)")
            })
            .disposed(by: bag)
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
}
