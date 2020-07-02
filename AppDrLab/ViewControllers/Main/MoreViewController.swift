//
//  MoreViewController.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setGradientBackground()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        userDefaults.set(false, forKey: kUSER_LOGGED_IN)
        userDefaults.set(nil, forKey: kUSER_EMAIL)
        userDefaults.synchronize()
        // got to main App
        let authenticationNavigationController = UIStoryboard(name: "Authentication", bundle: .main).instantiateViewController(withIdentifier: "AuthenticationNavController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(authenticationNavigationController)
    }
    
    private func setupViews() {
        logoutButton.styleFilledButton()
    }
}
