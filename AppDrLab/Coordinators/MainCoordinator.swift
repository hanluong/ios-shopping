//
//  MainCoordinator.swift
//  AppDrLab
//
//  Created by Han Luong on 6/15/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    private(set) var childCoordinator = [Coordinator]()
    private let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let homeVC  = HomeViewController.instantiateViewController(with: StoryboardName.main.value)
        let categoryVC = CategoryViewController.instantiateViewController(with: StoryboardName.main.value)
        let channelVC = ChannelViewController.instantiateViewController(with: StoryboardName.main.value)
        let moreVC = MoreViewController.instantiateViewController(with: StoryboardName.main.value)
        self.tabBarController.setViewControllers([homeVC, categoryVC, channelVC, moreVC], animated: false)
    }
    
    
}
