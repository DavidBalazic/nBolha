//
//  CategoriesViewModel.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import Foundation
import nBolhaNetworking

protocol CategoriesNavigationDelegate: AnyObject {
    func showCategoriesDetailScreen()
    func showCategoriesScreen()
    func showFilterScreen()
}

final class CategoriesViewModel: ObservableObject {
    private let navigationDelegate: CategoriesNavigationDelegate?
    @Published var isLoading = false
    @Published var advertisements: [Advertisement] = []
    
    init(
        navigationDelegate: CategoriesNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
        Task {
            await loadAdvertisements()
        }
    }
    
    private func loadAdvertisements() async{
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementWorker = AdvertisementWorker()
        advertisementWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.advertisements = response ?? []
            }
        }
    }
    
    func categoriesItemTapped() {
        navigationDelegate?.showCategoriesDetailScreen()
    }
    
    func browseCategoriesTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
}
