//
//  HomeViewModel.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import Foundation
import RxSwift

protocol HomeViewModelProtocol {
    var usersViewModel: UsersViewModelProtocol { get }
    var statisticsViewModel: StatisticsViewModelProtocol { get }
    var isLoading: BehaviorSubject<Bool> { get }
    var errorOccurred: PublishSubject<ServiceError> { get }
    
    func loadData()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let bag = DisposeBag()
    
    let usersViewModel: UsersViewModelProtocol
    let statisticsViewModel: StatisticsViewModelProtocol
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let errorOccurred = PublishSubject<ServiceError>()
    
    init(usersViewModel: UsersViewModelProtocol,
         statisticsViewModel: StatisticsViewModelProtocol) {
        self.usersViewModel = usersViewModel
        self.statisticsViewModel = statisticsViewModel
    }
    
    func loadData() {
        isLoading.onNext(true)
        
        ///Создаем Observable, который ждет загрузки и Users, и Statistics
        Observable.zip(
            usersViewModel.users.take(1),
            statisticsViewModel.statistics.take(1)
        )
        .subscribe(onNext: { [weak self] (users/*, statistics*/) in
            
            guard let self else { return }
            
            self.isLoading.onNext(false)
            
        }, onError: { [weak self] error in
            
            guard let self else { return }
            
            self.isLoading.onNext(false)
            
            self.errorOccurred.onNext(
                self.convertToServiceError(error, operation: .retrieve)
            )
        })
        .disposed(by: bag)
        
        ///Запускаем загрузку в обоих ViewModel
        usersViewModel.loadUsers()
        statisticsViewModel.loadStatistics()
    }
    
    private func convertToServiceError(
        _ error: Error, operation: ServiceOperation
    ) -> ServiceError {
        
        if let error = error as? ServiceError {
            return error
        }
        
        let error = error as NSError
        return .operation(operation, code: "\(error.code)")
    }
}
