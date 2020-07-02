//
//  CategoryViewModel.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

struct CategoryListViewModel {
    var categoriesViewModel = [CategoryViewModel]()
    
    func categoryViewModel(at index: Int) -> CategoryViewModel {
        return self.categoriesViewModel[index]
    }
}

struct CategoryViewModel {
    private let category: Category
}

extension CategoryViewModel {
    init(_ category: Category) {
        self.category = category
    }
}

extension CategoryViewModel {
    var name: String {
        return self.category.name
    }
    
    var id: String {
        return self.category.id
    }
}
