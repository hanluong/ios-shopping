//
//  UINavigation+Ext.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setGradientBackground() {
        let gradient = CAGradientLayer()
        var bounds = self.bounds
        bounds.size.height += window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        gradient.frame = bounds
        let startColor = UIColor(red: 29/255, green: 183/255, blue: 182/255, alpha: 1.0).cgColor // 1db7b6
        let endColor = UIColor(red: 67/255, green: 175/255, blue: 216/255, alpha: 1.0).cgColor // 43afd8
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        if let image = getImageFrom(gradientLayer: gradient) {
            self.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    private func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
