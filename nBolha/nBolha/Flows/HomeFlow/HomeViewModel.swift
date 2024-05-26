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
    }
    
    @MainActor
    private func loadRecentlyAdded() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementRecentlyAddedWorker = AdvertisementRecentlyAddedWorker()
        do {
            let response = try await advertisementRecentlyAddedWorker.execute()
            advertisementRecentlyAdded = response ?? []
        } catch {
            print("Error loading advertisements: \(error)")
        }
    }
    
    @MainActor
    private func loadRecentlyViewed() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementRecentlyViewedWorker = AdvertisementRecentlyViewedWorker()
        do {
            let response = try await advertisementRecentlyViewedWorker.execute()
            advertisementRecentlyViewed = response ?? []
        } catch {
            print("Error loading advertisements: \(error)")
        }
    }
    
    @MainActor
    private func likeAdvertisement(advertisementId: Int) async {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        do {
            _ = try await likeWorker.execute()
            if let index = advertisementRecentlyViewed.firstIndex(where: { $0.advertisementId == advertisementId }) {
                advertisementRecentlyViewed[index].isInWishlist = true
            }
            if let index = advertisementRecentlyAdded.firstIndex(where: { $0.advertisementId == advertisementId }) {
                advertisementRecentlyAdded[index].isInWishlist = true
            }
        } catch {
            print("Error liking advertisement: \(error)")
        }
    }
    
    @MainActor
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        do {
            _ = try await dislikeWorker.execute()
            if let index = advertisementRecentlyViewed.firstIndex(where: { $0.advertisementId == advertisementId }) {
                advertisementRecentlyViewed[index].isInWishlist = false
            }
            if let index = advertisementRecentlyAdded.firstIndex(where: { $0.advertisementId == advertisementId }) {
                advertisementRecentlyAdded[index].isInWishlist = false
            }
        } catch {
            print("Error disliking advertisement: \(error)")
        }
    }
    
    func likeAdvertisementTapped(advertisementId: Int) {
        Task { await likeAdvertisement(advertisementId: advertisementId) }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
    }
    
    func onAppear() {
        Task {
            await loadRecentlyViewed()
            await loadRecentlyAdded()
        }
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
        isEditing = false
        navigationDelegate?.showCategoryDetailScreen(search: search)
    }
}
