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
    
    @MainActor
    private func loadDetailAdvertisement(advertisementId: Int) async {
        let advertisementViewedWorker = AdvertisementViewedWorker(advertisementId: advertisementId)
        do {
            let response = try await advertisementViewedWorker.execute()
            advertisement = response
            calculateTextLimit()
        } catch {
            print("Error loading advertisements: \(error)")
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
    
    @MainActor
    private func likeAdvertisement(advertisementId: Int) async {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        do {
            _ = try await likeWorker.execute()
            advertisement?.isInWishlist = true
        } catch {
            print("Error liking advertisement: \(error)")
        }
    }
    
    @MainActor
    private func dislikeAdvertisement(advertisementId: Int) async {
        let dislikeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        do {
            _ = try await dislikeWorker.execute()
            advertisement?.isInWishlist = false
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
        Task { await loadDetailAdvertisement(advertisementId: advertisementId) }
    }
    
    func contactSellerTapped() {
        navigationDelegate?.showMailApp(
            recipientEmail: advertisement?.username ?? "",
            subject: advertisement?.title ?? ""
        )
    }
}
