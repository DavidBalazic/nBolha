//
//  HomeViewModel.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import Foundation
import nBolhaNetworking
import UIKit

protocol HomeNavigationDelegate: AnyObject {
    func showCategoriesScreen()
    func showDetailScreen(selectedAdvertisement: Advertisement)
}

final class HomeViewModel: ObservableObject {
    private let navigationDelegate: HomeNavigationDelegate?
    @Published var isLoading = false
    @Published var advertisementRecentlyAdded: [Advertisement] = []
    @Published var advertisementRecentlyViewed: [Advertisement] = []
    
    init(
        navigationDelegate: HomeNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
        Task {
            await loadRecentlyAdded()
            await loadRecentlyViewed()
        }
    }
    
    func loadRecentlyAdded() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementRecentlyAddedWorker = AdvertisementRecentlyAddedWorker()
        advertisementRecentlyAddedWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.advertisementRecentlyAdded = response ?? []
            }
        }
    }
    
    func loadRecentlyViewed() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementRecentlyViewedWorker = AdvertisementRecentlyViewedWorker()
        advertisementRecentlyViewedWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.advertisementRecentlyViewed = response ?? []
            }
        }
    }
    
    func likeAdvertisement(advertisementId: Int) {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        likeWorker.execute { [weak self] (_, error) in
            guard error == nil else {
                return
            }
            
            if let index = self?.advertisementRecentlyViewed.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyViewed[index].isInWishlist = true
            }
            if let index = self?.advertisementRecentlyAdded.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyAdded[index].isInWishlist = true
            }
        }
    }
    
    func dislikeAdvertisement(advertisementId: Int) {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        dislikeWorker.execute { [weak self] (_, error) in
            guard error == nil else {
                return
            }
            
            if let index = self?.advertisementRecentlyViewed.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyViewed[index].isInWishlist = false
            }
            if let index = self?.advertisementRecentlyAdded.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyAdded[index].isInWishlist = false
            }
        }
    }
    
    // MARK: - HomeNavigationDelegate
    
    func startExploringTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
    
    func advertisementItemTapped(selectedAdvertisement: Advertisement) {
        guard let advertisementId = selectedAdvertisement.advertisementId else { return }
        let advertisementViewedWorker = AdvertisementViewedWorker(advertisementId: advertisementId)
        advertisementViewedWorker.execute()
        
        navigationDelegate?.showDetailScreen(selectedAdvertisement: selectedAdvertisement)
    }
}
