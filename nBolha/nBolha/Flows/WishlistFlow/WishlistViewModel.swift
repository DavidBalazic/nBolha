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
    
    init(
        navigationDelegate: WishlistNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    private func likeAdvertisement(advertisementId: Int) {
        let likeWorker = AddToWishlistWorker(advertisementId: advertisementId)
        likeWorker.execute()
    }
    
    private func dislikeAdvertisement(advertisementId: Int) {
        let likeWorker = DeleteWishlistWorker(advertisementId: advertisementId)
        likeWorker.execute()
    }
}
