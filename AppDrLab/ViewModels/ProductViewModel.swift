//
//  ProductViewModel.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

struct ProductListViewModel {
    var productsViewModel = [ProductViewModel]()
    
    func productViewModel(at index: Int) -> ProductViewModel {
        return self.productsViewModel[index]
    }
}

struct ProductViewModel {
    private let product: Product
}

extension ProductViewModel {
    init(_ product: Product) {
        self.product = product
    }
}

extension ProductViewModel {
    var imagePath: String {
        return self.product.imagePath
    }
    
    var title: String {
        return self.product.title
    }
    
    var categoryName: String {
        return self.product.categoryName
    }
    
    var date: String {
        return self.product.date
    }
    
    var countLike: String {
        return "\(self.product.numLike)"
    }
    
    var countRep: String {
        return "\(self.product.numRep)"
    }
    
    var detail: Resource<Html?> {
        return self.product.getProductDetail()
    }
}
