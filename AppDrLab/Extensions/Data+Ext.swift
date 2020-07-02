//
//  Data+Ext.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
