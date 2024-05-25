//
//  WishlistView.swift
//  nBolha
//
//  Created by David Balažic on 6. 5. 24.
//

import SwiftUI
import NChainUI
import nBolhaUI

struct WishlistView: View {
    @ObservedObject private var viewModel: WishlistViewModel
    
    init(
        viewModel: WishlistViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                Text("My wishlist")
                    .textStyle(.subtitle02)
                    .foregroundStyle(Color(.brandTertiary!))
                    .frame(maxWidth: .infinity, alignment: .leading)
                if viewModel.wishlistAdvertisements.isEmpty {
                    EmptyWishlistView()
                } else {
                    AdvertisementGridView(
                        advertisements: viewModel.wishlistAdvertisements,
                        itemTapped: { advertisement in
                            viewModel.advertisementItemTapped(advertisementId: advertisement.advertisementId ?? 0)
                        },
                        likeButtonTapped: { _ in 
                        },
                        dislikeButtonTapped: { advertisement in
                            viewModel.dislikeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                        }
                    )
                }
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
        }
        .onAppear {
            Task { await viewModel.loadWishlist() }
        }
        .activityIndicator(show: $viewModel.isLoading)
    }
}
