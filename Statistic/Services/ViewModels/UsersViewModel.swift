//
//  UsersViewModel.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

import Foundation
import RxSwift

protocol UsersViewModelProtocol {
    func loadUsers()
    
    var users: PublishSubject<[User]> { get }
    var isLoading: BehaviorSubject<Bool> { get }
    var errorOccurred: PublishSubject<ServiceError> { get }
}

final class UsersViewModel: UsersViewModelProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let usersBase: UsersBaseProtocol
    private let bag = DisposeBag()
    
    let users = PublishSubject<[User]>()
    let isLoading = BehaviorSubject<Bool>(value: false)
    let errorOccurred = PublishSubject<ServiceError>()
    
    init(networkService: NetworkServiceProtocol,
         usersBase: UsersBaseProtocol) {
        self.networkService = networkService
        self.usersBase = usersBase
    }
    
    
    func loadUsers() {
        isLoading.onNext(true)
        
        loadUsersData()
            .subscribe { [weak self] usersResponse in
                guard let self else { return }
                
                isLoading.onNext(false)
                users.onNext(usersResponse)
                
            } onError: { [weak self] error in
                guard let self else { return }
                
                isLoading.onNext(false)
                errorOccurred.onNext(convertToServiceError(
                    error, operation: .retrieve))
            }
            .disposed(by: bag)
    }
    
    private func loadUsersData() -> Observable<[User]> {
        return Observable.create { [weak self] observer in
            guard let self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            Task {
                ///1. Пробуем загрузить из базы
                do {
                    let usersResponse =  try await self.usersBase.retrieveUsers()
                    
                    if !usersResponse.isEmpty {
                        observer.onNext(usersResponse)
                        observer.onCompleted()
                        return
                    }
                } catch {
                    ///Логируем ошибку но продолжаем выполнение
                    assertionFailure(
                        self.convertToServiceError(
                            error, operation: .retrieve).message)
                }
                
                ///2. Если база пуста - загружаем из сети
                do {
                    let userList: UserList = try await self.networkService.retrieveData(.baseServer(.users))
                    
                    observer.onNext(userList.users)
                    observer.onCompleted()
                    
                    ///3. Этот "do" блок я вынес отдельно, чтобы ошибка не попал в публичную переменную "errorOccurred", ведь эту переменную могут использовать для alert, а пользователь не должен знать об ошибке с базой
                    do {
                        try await self.usersBase.saveUsers(userList.users)
                    } catch {
                        assertionFailure(
                            self.convertToServiceError(
                                error, operation: .insertion).message)
                    }
                } catch {
                    ///Пробрасываем только сетевые ошибки
                    observer.onError(self.convertToServiceError(
                        error, operation: .retrieve))
                }
            }
            return Disposables.create()
        }
    }
    
    private func convertToServiceError(
        _ error: Error, operation: ServiceOperation) -> ServiceError {
            
        if let error = error as? ServiceError {
            return error
        }
        
        let error = error as NSError
        return .operation(operation, code: "\(error.code)")
    }
}
