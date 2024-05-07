//
//  WishlistView.swift
//  nBolha
//
//  Created by David Balažic on 6. 5. 24.
//

import SwiftUI

struct WishlistView: View {
    @ObservedObject private var viewModel: WishlistViewModel
    
    init(
        viewModel: WishlistViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.wishlistAdvertisements.isEmpty {
                Text("No items in wishlist")
            } else {
                List {
                    ForEach(viewModel.wishlistAdvertisements, id: \.advertisementId) { advertisement in
                        Text(advertisement.title ?? "No title")
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadWishlist()
            }
        }
    }
}
