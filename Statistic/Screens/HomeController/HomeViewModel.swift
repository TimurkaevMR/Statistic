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
    
    func loadData()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let bag = DisposeBag()
    
    let usersViewModel: UsersViewModelProtocol
    let statisticsViewModel: StatisticsViewModelProtocol
    
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    init(usersViewModel: UsersViewModelProtocol,
         statisticsViewModel: StatisticsViewModelProtocol) {

        self.usersViewModel = usersViewModel
        self.statisticsViewModel = statisticsViewModel
    }
    
    func loadData() {
        
    }
}
