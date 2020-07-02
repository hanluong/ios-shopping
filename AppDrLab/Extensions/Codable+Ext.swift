//
//  Codable+Ext.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: String] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
      throw NSError()
    }
    return dictionary
  }
}
