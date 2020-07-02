//
//  Category.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

struct CategoryList: Codable {
    let categories: [Category]
    
    private enum CodingKeys: String, CodingKey {
        case categories = "data_array"
    }
}

struct Category: Codable {
    let id: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "category_idx"
        case name = "category_name"
    }
}

extension Category {
    static var all: Resource<CategoryList?> = {
        guard let url = URL(string: "http://dev-api.martjangbogo.com/board_v_1_0_0/channel_category_list") else { fatalError() }
        let boundary = generateBoundary()
        return Resource<CategoryList?>(url: url, boundary: boundary)
    }()
    
    static func getProduct(by categoryId: String) -> Resource<ProductList?> {
        guard let url = URL(string: "http://dev-api.martjangbogo.com/board_v_1_0_0/channel_list") else { fatalError() }
        let parameters = ["member_idx": userDefaults.string(forKey: kUSER_ID)!, "category_idx": categoryId, "page_num": "1"] as [String : String]
        let boundary = generateBoundary()
        var resource = Resource<ProductList?>(url: url, boundary: boundary)
        resource.allHTTPHeaderFields = parameters
        
        return resource
    }
}
