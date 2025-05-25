//
//  HomeViewController.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let usersViewModel: UsersViewModelProtocol
    private let statisticsViewModel: StatisticsViewModelProtocol
    private let disposeBag = DisposeBag()
    private var currentUsers: [User] = []
    
    
    init(usersViewModel: UsersViewModelProtocol,
         statisticsViewModel: StatisticsViewModelProtocol) {

        self.usersViewModel = usersViewModel
        self.statisticsViewModel = statisticsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
        usersViewModel.loadUsers()
    }
    
    // MARK: - Настройка UI
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Привязка ViewModel
    private func bindViewModel() {
        // Загрузка данных
        viewModel.users
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] users in
                
                guard let self else { return }
                self.currentUsers = users
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                
                guard let self else { return }
                isLoading ? activityIndicator.startAnimating() :
                activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.errorOccurred
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                
                guard let self else { return }
                self.showErrorAlert(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func showErrorAlert(error: ServiceError) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: error.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = currentUsers[indexPath.row]
        cell.textLabel?.text = user.username
        return cell
    }
}
