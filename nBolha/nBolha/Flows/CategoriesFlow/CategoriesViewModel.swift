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
    func showDetailScreen(selectedAdvertisement: Advertisement)
}

final class CategoriesViewModel: ObservableObject {
    private let navigationDelegate: CategoriesNavigationDelegate?
    @Published var isLoading = false
    @Published var advertisements: [Advertisement] = []
    @Published var selectedAdvertisement: Advertisement?
    
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
    
    func advertisementItemTapped(selectedAdvertisement: Advertisement) {
        guard let advertisementId = selectedAdvertisement.advertisementId else { return }
        let advertisementViewedWorker = AdvertisementViewedWorker(advertisementId: advertisementId)
        advertisementViewedWorker.execute()
        
        navigationDelegate?.showDetailScreen(selectedAdvertisement: selectedAdvertisement)
    }
    
    func showFilterTapped() {
        navigationDelegate?.showFilterScreen()
    }
}
