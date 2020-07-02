//
//  Product.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

struct ProductList: Codable {
    let products: [Product]
    
    private enum CodingKeys: String, CodingKey {
        case products = "data_array"
    }
}

struct Product: Codable {
    let boardId: String
    let title: String
    let imagePath: String
    let date: String
    let numLike: String
    let numRep: String
    let categoryName: String
    
    private enum CodingKeys: String, CodingKey {
        case boardId = "board_idx"
        case title = "title"
        case imagePath = "img_path"
        case date = "ins_date"
        case numLike = "like_cnt"
        case numRep = "reply_cnt"
        case categoryName = "category"
    }
    
    func getProductDetail() -> Resource<Html?> {
        guard let url = URL(string: "http://dev-api.martjangbogo.com/board_v_1_0_0/channel_detail?board_idx=\(boardId)&member_idx=\(userDefaults.string(forKey: kUSER_ID)!)") else { fatalError() }
        let boundary = generateBoundary()
        let resource = Resource<Html?>(url: url, boundary: boundary)
        return resource
    }
}
