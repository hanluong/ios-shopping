//
//  LoginCoordinator.swift
//  AppDrLab
//
//  Created by Han Luong on 6/15/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    private(set) var childCoordinator = [Coordinator]()
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController.instantiateViewController(with: StoryboardName.authentication.value)
        self.navigationController.setViewControllers([vc], animated: false)
    }
}
