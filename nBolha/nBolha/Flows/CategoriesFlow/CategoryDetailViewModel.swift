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
    @Published var search = ""
    @Published var isEditing = false
    
    init(
        navigationDelegate: CategoryDetailNavigationDelegate?,
        category: String? = nil,
        search: String? = nil
    ) {
        self.navigationDelegate = navigationDelegate
        self.category = category
        self.search = search ?? ""
    }
    
    @MainActor
    private func loadFilteredAdvertisements() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let filterAdvertisementWorker = FilterAdvertisementWorker(
            category: category,
            keyword: search,
            orderBy: order.backendValue,
            conditions: conditions.map { $0.backendValue }
        )
        do {
            let response = try await filterAdvertisementWorker.execute()
            advertisements = response ?? []
        } catch {
            print("Error loading advertisements: \(error)")
        }
    }
    
    @MainActor
    private func likeAdvertisement(advertisementId: Int) async {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        do {
            _ = try await likeWorker.execute()
            if let index = advertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                advertisements[index].isInWishlist = true
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
            if let index = advertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                advertisements[index].isInWishlist = false
            }
        } catch {
            print("Error disliking advertisement: \(error)")
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
        conditions = selectedCheckBoxes
        order = selectedRadioButton
        Task { await loadFilteredAdvertisements() }
    }
    
    func applySearchTapped() {
        isEditing = false
        Task { await loadFilteredAdvertisements() }
    }
    
    func likeAdvertisementTapped(advertisementId: Int) {
        Task { await likeAdvertisement(advertisementId: advertisementId) }
    }
    
    func dislikeAdvertisementTapped(advertisementId: Int) {
        Task { await dislikeAdvertisement(advertisementId: advertisementId) }
    }
    
    func onAppear() {
        Task { await loadFilteredAdvertisements()}
    }
    
    func browseCategoriesTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
    
    func advertisementItemTapped(advertisementId: Int) {
        navigationDelegate?.showDetailScreen(advertisementId: advertisementId)
    }
}
