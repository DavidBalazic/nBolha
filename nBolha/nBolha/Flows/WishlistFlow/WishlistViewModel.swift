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
    
    func loadWishlist() async {
        guard !isLoading else { return }
        DispatchQueue.main.async {
            self.isLoading = true
        }
        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        let getWishlistWorker = GetWishlistWorker()
        getWishlistWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.wishlistAdvertisements = response ?? []
            }
        }
    }
    
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        dislikeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            if let index = self?.wishlistAdvertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                self?.wishlistAdvertisements.remove(at: index)
            }
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
