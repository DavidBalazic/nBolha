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
//    func showCategoriesScreen()
}

final class CategoriesViewModel: ObservableObject {
    private let navigationDelegate: CategoriesNavigationDelegate?

    init(
        navigationDelegate: CategoriesNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    func categoriesItemTapped(category: String) {
        navigationDelegate?.showCategoriesDetailScreen(category: category)
    }
}

