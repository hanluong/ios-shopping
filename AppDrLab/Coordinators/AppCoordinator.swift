//
//  AppCoordinator.swift
//  AppDrLab
//
//  Created by Han Luong on 6/15/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private(set) var childCoordinator = [Coordinator]()
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if userDefaults.bool(forKey: kUSER_LOGGED_IN) {
//            let tabBarController = UITabBarController()
//            let mainCoordinator = MainCoordinator(tabBarController: tabBarController)
//            mainCoordinator.start()
//            childCoordinator.append(mainCoordinator)
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateInitialViewController()
            window.rootViewController = vc
        } else {
            let navigationController = UINavigationController()
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            loginCoordinator.start()
            childCoordinator.append(loginCoordinator)
            self.window.rootViewController = navigationController
        }
        
        self.window.makeKeyAndVisible()
    }
    
    
}
