//
//  WishlistViewModel.swift
//  nBolha
//
//  Created by David Balažic on 6. 5. 24.
//

import Foundation
import nBolhaNetworking

protocol WishlistNavigationDelegate: AnyObject {
 
}

final class WishlistViewModel: ObservableObject {
    private let navigationDelegate: WishlistNavigationDelegate?
    @Published var isLoading = false
    @Published var wishlistAdvertisements: [Advertisement] = []
    
    init(
        navigationDelegate: WishlistNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
        Task {
            await loadWishlist()
        }
    }
    
    func loadWishlist() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let getWishlistWorker = GetWishlistWorker()
        getWishlistWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.wishlistAdvertisements = response ?? []
            }
        }
    }
}
