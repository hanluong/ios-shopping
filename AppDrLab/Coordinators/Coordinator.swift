//
//  Coordinator.swift
//  AppDrLab
//
//  Created by Han Luong on 6/15/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

protocol Coordinator {
    var childCoordinator: [Coordinator] { get }
    
    func start()
}
