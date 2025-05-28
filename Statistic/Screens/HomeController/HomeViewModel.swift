//
//  HomeViewModel.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import Foundation
import RxSwift

protocol HomeViewModelProtocol {
    var usersVM: UsersViewModelProtocol { get }
    var statisticsVM: StatisticsViewModelProtocol { get }
    var isLoading: BehaviorSubject<Bool> { get }
    var errorOccurred: PublishSubject<ServiceError> { get }
    
    var frequentVisitors: [User] { get set }
    var demographicStats: [Grade: GendersValue] { get set }
    
    func loadData()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let bag = DisposeBag()
    
    let usersVM: UsersViewModelProtocol
    let statisticsVM: StatisticsViewModelProtocol
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let errorOccurred = PublishSubject<ServiceError>()
    
    var frequentVisitors: [User] = []
    var demographicStats: [Grade: GendersValue] = [:]
    private var users: [User] = []
    private var statistics: [UserStatistic] = []
    
    init(usersViewModel: UsersViewModelProtocol,
         statisticsViewModel: StatisticsViewModelProtocol) {
        self.usersVM = usersViewModel
        self.statisticsVM = statisticsViewModel
    }
    
    func loadData() {
        isLoading.onNext(true)
        
        ///Создаем Observable, который ждет загрузки и Users, и Statistics
        Observable.zip(
            usersVM.users.take(1),
            statisticsVM.statistics.take(1)
        )
        .subscribe(onNext: { [weak self] users, statistics in
            guard let self else { return }
            self.users = users
            self.statistics = statistics
            
            Task {
                self.frequentVisitors = await self.getFrequentVisitors()
                self.demographicStats = await self.getDemographicStats()
                self.isLoading.onNext(false)
            }
            
        }, onError: { [weak self] error in
            
            guard let self else { return }
            
            self.isLoading.onNext(false)
            
            self.errorOccurred.onNext(
                self.convertToServiceError(error, operation: .retrieve)
            )
        })
        .disposed(by: bag)
        
        ///Запускаем загрузку в обоих ViewModel
        usersVM.loadUsers()
        statisticsVM.loadStatistics()
    }
    
    private func getFrequentVisitors() async -> [User] {
        ///Получаем 3 самых частых посетителей
        if statistics.count <= 3 {
            let validVisitors = users.filter({ user in
                statistics.contains(where: { $0.userId == user.id })
            })
            
            return validVisitors
        } else {
            let topVisitors = statistics.sorted(by: {
                $0.dates.count > $1.dates.count
            }).prefix(3)
            
            let validVisitors = users.filter({ user in
                topVisitors.contains(where: { $0.userId == user.id })
            })
            
            return validVisitors
        }
    }
    
    private func getDemographicStats() async -> [Grade: GendersValue] {
        return users.reduce(into: [:]) { result, user in
            let grade = Grade.from(age: user.age)
            result[grade, default: GendersValue(male: 0, female: 0)].add(user.sex)
        }
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
