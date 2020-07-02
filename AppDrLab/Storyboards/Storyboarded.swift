//
//  Storyboarded.swift
//  AppDrLab
//
//  Created by Han Luong on 6/15/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiateViewController(with storyboardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiateViewController(with storyboardName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}

enum StoryboardName: String {
    case main
    case authentication
    var value: String {
        return rawValue.capitalized
    }
}
