//
//  LoginViewController.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit
import KRProgressHUD

class LoginViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var keepLoginButton: UIButton!
    @IBOutlet weak var warningEmailError: UIStackView!
    
    // MARK: - Vars
    var isKeepLoginInfo = true
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapToDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToDismissKeyboard)
        
        setupViews()
    }

    // MARK: - IBActions
    @IBAction func emailEditingDidEnd(_ sender: UITextField) {
        if let emailText = sender.text, isValidEmail(emailText) {
            warningEmailError.isHidden = true
            loginButton.isEnabled = true
        } else {
            warningEmailError.isHidden = false
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        KRProgressHUD.show()
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if warningEmailError.isHidden && password != "" {
            loginViewModel.email = email
            loginViewModel.password = password
            loginViewModel.token = "2"
            loginViewModel.os = "I"
            WebService().load(resource: User.login(vm: loginViewModel)) { result in
                KRProgressHUD.dismiss()
                
                switch result {
                case .success(let user):
                    userDefaults.set(true, forKey: kUSER_LOGGED_IN)
                    userDefaults.set(user!.email, forKey: kUSER_EMAIL)
                    userDefaults.set(user!.id, forKey: kUSER_ID)
                    userDefaults.synchronize()
                    
                    // goto main app
                    let mainTabBarController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MainTabBarController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "로그인 오류", message: "아이디를 입력해주세요!", preferredStyle: .alert)
                        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                        alert.addAction(actionCancel)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    // for debug log
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func keepLoginButtonTapped(_ sender: UIButton) {
        if isKeepLoginInfo {
            keepLoginButton.setImage(UIImage(named: "uncheck"), for: .normal)
        } else {
            keepLoginButton.setImage(UIImage(named: "check"), for: .normal)
        }
        isKeepLoginInfo = !isKeepLoginInfo
    }
    
    // MARK: - Helper funcs
    private func setupViews() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        loginButton.styleFilledButton()
        loginButton.isEnabled = false
        warningEmailError.isHidden = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

