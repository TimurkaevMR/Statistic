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
        
        let networkService = NetworkService()
        let userBase = UsersRealmService()
        let viewModel = UsersViewModel(networkService: networkService,
                                       usersBase: userBase)
        let viewController = HomeViewController(viewModel: viewModel)
        
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
