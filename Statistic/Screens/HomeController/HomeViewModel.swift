//
//  HomeViewModel.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import Foundation
import RxSwift

protocol HomeViewModelProtocol {
    var frequentVisitors: [User] { get set }
    var demographicStats: [Grade: GendersValue] { get set }
    var dailyVisits: [(date: Int, count: Int)] { get set }
    var subscribers: [(date: Int, count: Int)] { get set }
    var unsubscribers: [(date: Int, count: Int)] { get set }
    
    var isLoading: BehaviorSubject<Bool> { get }
    var errorOccurred: PublishSubject<ServiceError> { get }
    
    func loadData()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let usersVM: UsersViewModelProtocol
    private let statisticsVM: StatisticsViewModelProtocol
    
    private var users: [User] = []
    private var statistics: [UserStatistic] = []
    private let bag = DisposeBag()
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let errorOccurred = PublishSubject<ServiceError>()
    
    var frequentVisitors: [User] = []
    var demographicStats: [Grade: GendersValue] = [:]
    var dailyVisits: [(date: Int, count: Int)] = []
    var subscribers: [(date: Int, count: Int)] = []
    var unsubscribers: [(date: Int, count: Int)] = []
    
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
                
                let visitors = await self.getFrequentVisitors()
                await MainActor.run {
                    self.frequentVisitors = visitors
                }
                self.demographicStats = await self.getDemographicStats()
                self.dailyVisits = self.getUsers(type: .view)
                self.subscribers = self.getUsers(type: .subscription)
                self.unsubscribers = self.getUsers(type: .unsubscription)
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
        
        usersVM.loadUsers()
        statisticsVM.loadStatistics()
    }
}

private extension HomeViewModel {
    func getFrequentVisitors() async -> [User] {
        ///Получаем 3 самых частых посетителя
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
    
    func getDemographicStats() async -> [Grade: GendersValue] {
        return users.reduce(into: [:]) { result, user in
            let grade = Grade.from(age: user.age)
            result[grade, default: GendersValue(male: 0, female: 0)].add(user.sex)
        }
    }
    
    func getUsers(
        type: UserStatistic.StatisticType) -> [(date: Int, count: Int)] {
            
        return statistics
            .filter({ $0.type == type })
            .flatMap({ $0.dates })
            .reduce(into: [:]) { datesDictionary, date in
                datesDictionary[date] = datesDictionary[date, default: 0] + 1
            }
            .map({ (date: $0.key, count: $0.value) })
            .sorted(by: { $0.date < $1.date })
    }
    
    func convertToServiceError(
        _ error: Error, operation: ServiceOperation
    ) -> ServiceError {
        
        if let error = error as? ServiceError {
            return error
        }
        
        let error = error as NSError
        return .operation(operation, code: "\(error.code)")
    }
}
