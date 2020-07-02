//
//  HomeViewController.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
    }
}
