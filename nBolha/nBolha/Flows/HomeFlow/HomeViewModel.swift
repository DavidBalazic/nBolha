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
    
    private func loadRecentlyAdded() async {
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
    
    private func loadRecentlyViewed() async {
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
    
    
    func startExploringTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
    
    func advertisementItemTapped(selectedAdvertisement: Advertisement) {
        let advertisementId = selectedAdvertisement.advertisementId!
        let advertisementViewedWorker = AdvertisementViewedWorker(advertisementId: advertisementId)
        advertisementViewedWorker.execute()
        
        navigationDelegate?.showDetailScreen(selectedAdvertisement: selectedAdvertisement)
    }
}
