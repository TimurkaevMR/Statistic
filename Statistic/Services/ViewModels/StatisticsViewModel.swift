//
//  StatisticsViewModelProtocol.swift
//  Statistic
//
//  Created by Malik Timurkaev on 25.05.2025.
//

//import Foundation
//import RxSwift
//
//protocol StatisticsViewModelProtocol {
//    func loadStatistics()
//    
//    var statistics: PublishSubject<[UserStatDTO]> { get }
//    var isLoading: BehaviorSubject<Bool> { get }
//    var errorOccurred: PublishSubject<ServiceError> { get }
//}
//
//final class StatisticsViewModel: StatisticsViewModelProtocol {
//    
//    private let networkService: NetworkServiceProtocol
//    private let statsBase: StatisticsBaseProtocol
//    private let bag = DisposeBag()
//    
//    let statistics = PublishSubject<[UserStatDTO]>()
//    let isLoading = BehaviorSubject<Bool>(value: false)
//    let errorOccurred = PublishSubject<ServiceError>()
//    
//    init(networkService: NetworkServiceProtocol,
//         statisticsBase: StatisticsBaseProtocol) {
//        self.networkService = networkService
//        self.statsBase = statisticsBase
//    }
//    
//    
//    func loadStatistics() {
//        isLoading.onNext(true)
//        
//        loadStatisticsData()
//            .subscribe { [weak self] statisticsResponse in
//                guard let self else { return }
//                
//                isLoading.onNext(false)
//                statistics.onNext(statisticsResponse)
//                
//            } onError: { [weak self] error in
//                guard let self else { return }
//                
//                isLoading.onNext(false)
//                errorOccurred.onNext(convertToServiceError(
//                    error, operation: .retrieve))
//            }
//            .disposed(by: bag)
//    }
//    
//    private func loadStatisticsData() -> Observable<[UserStatDTO]> {
//        return Observable.create { [weak self] observer in
//            guard let self else {
//                observer.onCompleted()
//                return Disposables.create()
//            }
//            
//            Task {
//                ///1. Пробуем загрузить из базы
//                do {
//                    let statsResponse =  try await self.statsBase.retrieveStatistics()
//                    
//                    if !statsResponse.isEmpty {
//                        observer.onNext(statsResponse)
//                        observer.onCompleted()
//                        return
//                    }
//                } catch {
//                    ///Логируем ошибку но продолжаем выполнение
//                    assertionFailure(
//                        self.convertToServiceError(
//                            error, operation: .retrieve).message)
//                }
//                
//                ///2. Если база пуста - загружаем из сети
//                do {
//                    let statisticList: StatListDTO = try await self.networkService.retrieveData(.baseServer(.statistics))
//                    
//                    observer.onNext(statisticList.statistics)
//                    observer.onCompleted()
//                    
//                    ///3. Этот "do" блок я вынес отдельно, чтобы ошибка не попал в публичную переменную "errorOccurred", ведь эту переменную могут использовать для alert, а пользователь не должен знать об ошибке с базой
//                    do {
//                        try await self.statsBase.saveStatistics(statisticList.statistics)
//                    } catch {
//                        assertionFailure(
//                            self.convertToServiceError(
//                                error, operation: .insertion).message)
//                    }
//                } catch {
//                    ///Пробрасываем только сетевые ошибки
//                    observer.onError(self.convertToServiceError(
//                        error, operation: .retrieve))
//                }
//            }
//            return Disposables.create()
//        }
//    }
//    
//    private func convertToServiceError(
//        _ error: Error, operation: ServiceOperation) -> ServiceError {
//            
//        if let error = error as? ServiceError {
//            return error
//        }
//        
//        let error = error as NSError
//        return .operation(operation, code: "\(error.code)")
//    }
//}
