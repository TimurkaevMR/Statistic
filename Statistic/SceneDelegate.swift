//
//  SceneDelegate.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = UINavigationController(rootViewController: homeViewController())
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func homeViewController() -> HomeViewController {
        ///Создаем NetworkService для моделей
        let networkService = NetworkService()
        
        ///Создаем StatisticsViewModel
        let statisticsBase = StatisticsRealmService()
        let statisticsViewModel = StatisticsViewModel(
            networkService: networkService, statisticsBase: statisticsBase)
        
        ///Создаем UsersViewModel
        let userBase = UsersRealmService()
        let usersViewModel = UsersViewModel(
            networkService: networkService, usersBase: userBase)
        
        ///Создаем HomeViewModel, который принимает выше созданные модели
        let homeViewModel = HomeViewModel(
            usersViewModel: usersViewModel,
            statisticsViewModel: statisticsViewModel)
        
        return HomeViewController(vm: homeViewModel)
    }
}
