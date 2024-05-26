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
    func showMailApp(recipientEmail: String, subject: String)
}

final class DetailViewModel: ObservableObject{
    private let navigationDelegate: DetailNavigationDelegate?
    private let advertisementId: Int
    @Published var isLoading = false
    @Published var advertisement: Advertisement?
    @Published var shouldShowTextLimit = false
    @Published var showButton = false
    
    init(
        navigationDelegate: DetailNavigationDelegate?,
        advertisementId: Int
    ) {
        self.navigationDelegate = navigationDelegate
        self.advertisementId = advertisementId
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
                self.calculateTextLimit()
            }
        }
    }
    
    private func calculateTextLimit() {
        guard let advertisement = advertisement else { return }
        if let description = advertisement.description {
            let lineHeight = UIFont.body02.lineHeight
            let height = description.height(withConstrainedWidth: UIScreen.main.bounds.width, font: UIFont.body02)
            let numberOfLines = Int(height / lineHeight)
            shouldShowTextLimit = numberOfLines > 4
            self.showButton = numberOfLines > 4
        }
    }
    
    func toggleTextLimit() {
        shouldShowTextLimit.toggle()
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
    
    func onAppear() {
        Task { await loadDetailAdvertisement(advertisementId: advertisementId) }
    }
    
    func contactSellerTapped() {
        navigationDelegate?.showMailApp(
            recipientEmail: advertisement?.username ?? "",
            subject: advertisement?.title ?? ""
        )
    }
}
