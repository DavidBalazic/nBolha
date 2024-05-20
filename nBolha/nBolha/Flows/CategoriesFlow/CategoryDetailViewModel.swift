//
//  CategoriesViewModel.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import Foundation
import nBolhaNetworking
import nBolhaUI

protocol CategoryDetailNavigationDelegate: AnyObject {
    func showCategoriesScreen()
    func showDetailScreen(advertisementId: Int)
}

final class CategoryDetailViewModel: ObservableObject {
    private let navigationDelegate: CategoryDetailNavigationDelegate?
    @Published var isLoading = false
    @Published var advertisements: [Advertisement] = []
    @Published var category: String?
    @Published var conditions: [Condition] = []
    @Published var order: SortBy = .newest
    
    init(
        navigationDelegate: CategoryDetailNavigationDelegate?,
        category: String
    ) {
        self.navigationDelegate = navigationDelegate
        self.category = category
        Task {
            await loadFilteredAdvertisements()
        }
    }
    
    private func loadFilteredAdvertisements() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let filterAdvertisementWorker = FilterAdvertisementWorker(
            category: category,
            orderBy: order.rawValue,
            conditions: conditions.map { $0.rawValue }
        )
        filterAdvertisementWorker.execute { (response, error) in
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
    
    func removeFilterTapped(value: String) {
        if let condition = Condition(rawValue: value), let index = conditions.firstIndex(of: condition) {
            conditions.remove(at: index)
        } else if SortBy(rawValue: value) != nil {
            order = .newest
        }
        Task { await loadFilteredAdvertisements() }
    }
    
    func applyFiltersTapped(selectedCheckBoxes: [Condition], selectedRadioButton: SortBy) {
        self.conditions = selectedCheckBoxes
        self.order = selectedRadioButton
        Task { await loadFilteredAdvertisements() }
    }
    
    func likeAdvertisementTapped(advertisementId: Int) {
        Task { await likeAdvertisement(advertisementId: advertisementId) }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
    }
    
    func browseCategoriesTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
    
    func advertisementItemTapped(advertisementId: Int) {
        navigationDelegate?.showDetailScreen(advertisementId: advertisementId)
    }
}
