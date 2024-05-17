//
//  DetailViewModel.swift
//  nBolha
//
//  Created by David Balažic on 19. 4. 24.
//

import Foundation
import nBolhaNetworking
import MessageUI

protocol DetailNavigationDelegate: AnyObject {
    func disableNavigations()
    func enableNavigations()
    func showMailApp()
}

final class DetailViewModel: ObservableObject{
    private let navigationDelegate: DetailNavigationDelegate?
    private let advertisementId: Int
    @Published var isLoading = false
    @Published var advertisement: Advertisement?
    
    init(
        navigationDelegate: DetailNavigationDelegate?,
        advertisementId: Int
    ) {
        self.navigationDelegate = navigationDelegate
        self.advertisementId = advertisementId
        Task {
            await loadDetailAdvertisement(advertisementId: advertisementId)
        }
    }
    
    private func loadDetailAdvertisement(advertisementId: Int) async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementViewedWorker = AdvertisementViewedWorker(advertisementId: advertisementId)
        advertisementViewedWorker.execute { response, error in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.advertisement = response
            }
        }
    }
    
    func disableNavigations() {
        navigationDelegate?.disableNavigations()
    }
    
    func enableNavigations() {
        navigationDelegate?.enableNavigations()
    }
    
    private func likeAdvertisement(advertisementId: Int) async {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        likeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            self?.advertisement?.isInWishlist = true
        }
    }
    
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        dislikeWorker.execute { [weak self] (_, error) in
            guard error == nil else { return }
            
            self?.advertisement?.isInWishlist = false
        }
    }
    
    func likeAdvertisementTapped(advertisementId: Int) {
        Task { await likeAdvertisement(advertisementId: advertisementId) }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
    }
    
    func contactSellerTapped() {
        navigationDelegate?.showMailApp()
    }
}
