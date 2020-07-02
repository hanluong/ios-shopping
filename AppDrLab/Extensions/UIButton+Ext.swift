//
//  UIButton+Ext.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

extension UIButton {
    
    func styleFilledButton() {
        backgroundColor = nil
        self.layoutIfNeeded()
        let startColor = UIColor(red: 29/255, green: 183/255, blue: 182/255, alpha: 1.0).cgColor // 1db7b6
        let endColor = UIColor(red: 67/255, green: 175/255, blue: 216/255, alpha: 1.0).cgColor // 43afd8
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.size.height / 2.0
        layer.insertSublayer(gradientLayer, at: 0)
        tintColor = .white
        clipsToBounds = true
    }
    
    func styleHollowButton() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 29/255, green: 183/255, blue: 182/255, alpha: 1.0).cgColor // 1db7b6
        layer.cornerRadius = bounds.size.height / 2.0
        tintColor = UIColor(red: 29/255, green: 183/255, blue: 182/255, alpha: 1.0)
        clipsToBounds = true
    }
}
