//
//  CategoryDetailViewModel.swift
//  nBolha
//
//  Created by David Balažic on 20. 5. 24.
//

import Foundation
import nBolhaNetworking

protocol CategoriesNavigationDelegate: AnyObject {
    func showCategoriesDetailScreen(category: String)
    func showCategoryDetailScreen(search: String)
}

final class CategoriesViewModel: ObservableObject {
    private let navigationDelegate: CategoriesNavigationDelegate?
    @Published var search = ""
    @Published var isEditing = false

    init(
        navigationDelegate: CategoriesNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    func categoriesItemTapped(category: String) {
        navigationDelegate?.showCategoriesDetailScreen(category: category)
    }
    
    func applySearchTapped(search: String) {
        self.search = ""
        isEditing = false
        navigationDelegate?.showCategoryDetailScreen(search: search)
    }
}
