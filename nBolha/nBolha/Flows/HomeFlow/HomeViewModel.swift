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
    func showDetailScreen(advertisementId: Int)
    func showCategoryDetailScreen(search: String)
}

final class HomeViewModel: ObservableObject {
    private let navigationDelegate: HomeNavigationDelegate?
    @Published var isLoading = false
    @Published var advertisementRecentlyAdded: [Advertisement] = []
    @Published var advertisementRecentlyViewed: [Advertisement] = []
    @Published var search = ""
    @Published var isEditing = false
    
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
        DispatchQueue.main.async {
            self.isLoading = true
        }
        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
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
        DispatchQueue.main.async {
            self.isLoading = true
        }
        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        let advertisementRecentlyViewedWorker = AdvertisementRecentlyViewedWorker()
        advertisementRecentlyViewedWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.advertisementRecentlyViewed = response ?? []
            }
        }
    }
    
    private func likeAdvertisement(advertisementId: Int) async {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        likeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            if let index = self?.advertisementRecentlyViewed.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyViewed[index].isInWishlist = true
            }
            if let index = self?.advertisementRecentlyAdded.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyAdded[index].isInWishlist = true
            }
        }
    }
    
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        dislikeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            if let index = self?.advertisementRecentlyViewed.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyViewed[index].isInWishlist = false
            }
            if let index = self?.advertisementRecentlyAdded.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.advertisementRecentlyAdded[index].isInWishlist = false
            }
        }
    }
    
    func likeAdvertisementTapped(advertisementId: Int) {
        Task { await likeAdvertisement(advertisementId: advertisementId) }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
    }
    
    // MARK: - HomeNavigationDelegate
    
    func startExploringTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
    
    func advertisementItemTapped(advertisementId: Int) {
        navigationDelegate?.showDetailScreen(advertisementId: advertisementId)
    }
    
    func applySearchTapped(search: String) {
        self.search = ""
        self.isEditing = false
        navigationDelegate?.showCategoryDetailScreen(search: search)
    }
}
