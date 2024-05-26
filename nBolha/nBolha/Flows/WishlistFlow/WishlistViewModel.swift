//
//  WishlistViewModel.swift
//  nBolha
//
//  Created by David Balažic on 6. 5. 24.
//

import Foundation
import nBolhaNetworking

protocol WishlistNavigationDelegate: AnyObject {
    func showDetailScreen(advertisementId: Int)
}

final class WishlistViewModel: ObservableObject {
    private let navigationDelegate: WishlistNavigationDelegate?
    @Published var isLoading = false
    @Published var wishlistAdvertisements: [Advertisement] = []
    
    init(
        navigationDelegate: WishlistNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    @MainActor
    private func loadWishlist() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let getWishlistWorker = GetWishlistWorker()
        do {
            let response = try await getWishlistWorker.execute()
            wishlistAdvertisements = response ?? []
        } catch {
            print("Error loading advertisements: \(error)")
        }
    }
    
    @MainActor
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        do {
            _ = try await dislikeWorker.execute()
            if let index = wishlistAdvertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                wishlistAdvertisements.remove(at: index)
            }
        } catch {
            print("Error disliking advertisement: \(error)")
        }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
    }
    
    func onAppear() {
        Task { await loadWishlist() }
    }
    
    func advertisementItemTapped(advertisementId: Int) {
        navigationDelegate?.showDetailScreen(advertisementId: advertisementId)
    }
}
