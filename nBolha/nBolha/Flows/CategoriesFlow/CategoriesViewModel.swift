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
    
    func loadAdvertisements() async{
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
    
    private func likeAdvertisement(advertisementId: Int) async {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        likeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            if let index = self?.advertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisements[index].isInWishlist = true
            }
        }
    }
    
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        dislikeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            if let index = self?.advertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisements[index].isInWishlist = false
            }
        }
    }
    
    func likeAdvertisementTapped(advertisementId: Int) {
        Task { await likeAdvertisement(advertisementId: advertisementId) }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
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
}
