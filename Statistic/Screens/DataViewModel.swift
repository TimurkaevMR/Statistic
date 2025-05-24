//
//  DataViewModel.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation

protocol DataViewModelProtocol {
    
}

final class DataViewModel: DataViewModelProtocol {
    
    let networkService: NetworkServiceProtocol
    let usersBase: UsersBaseProtocol
    
    init(networkService: NetworkServiceProtocol,
         usersBase: UsersBaseProtocol) {
        self.networkService = networkService
        self.usersBase = usersBase
    }
    
    func retrieveUsers() {
        
    }
    
    func retrieveStatistics() {
        
    }
    
    private func dataBaseFetchUsers() {
        Task {
            do {
                let users = try await usersBase.retrieveUsers()
                print(users)
            } catch let error as ServiceError {
                print(error)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    private func dataBaseFetchStatistics() {
        
    }
    
    private func networkFetchUsers() {
        Task {
            do {
                let userList: UserList = try await networkService.retrieveData(.users)
                let users = userList.users
                print(users)
            } catch let error as ServiceError {
                print(error)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    private func networkFetchStatistics() {
        Task {
            do {
                let userList: UserList = try await networkService.retrieveData(.users)
                let users = userList.users
                print(users)
            } catch let error as ServiceError {
                print(error)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
