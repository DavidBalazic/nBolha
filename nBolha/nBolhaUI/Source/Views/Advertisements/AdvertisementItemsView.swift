//
//  RecentlyAddedView.swift
//  nBolha
//
//  Created by David Balažic on 10. 4. 24.
//

import SwiftUI
import nBolhaNetworking
import NChainUI

public struct AdvertisementItemsView: View {
    let advertisement: Advertisement
    let itemTapped: () -> Void
    let likeButtonTapped: () -> Void
    let dislikeButtonTapped: () -> Void

    public init(
        advertisement: Advertisement,
        itemTapped: @escaping () -> Void,
        likeButtonTapped: @escaping () -> Void,
        dislikeButtonTapped: @escaping () -> Void
    ) {
        self.advertisement = advertisement
        self.itemTapped = itemTapped
        self.likeButtonTapped = likeButtonTapped
        self.dislikeButtonTapped = dislikeButtonTapped
    }
    
    public var body: some View {
        Button(action: {
            itemTapped()
        }) {
            VStack(spacing: NCConstants.Margins.small.rawValue) {
                ZStack(alignment: .topTrailing) {
                    if let imageObject = advertisement.images?.first, let imageURL = imageObject.fullImageURL {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: 166)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(
                                cornerRadius: NCConstants.Radius.small.rawValue,
                                style: .continuous
                            )
                            .stroke(Color(UIColor.outline02!), lineWidth: 1)
                        )
                    }
                    LikeButton(
                        isLiked: advertisement.isInWishlist ?? false,
                        advertisementId: advertisement.advertisementId ?? 0,
                        likeButtonTapped: likeButtonTapped,
                        dislikeButtonTapped: dislikeButtonTapped
                    )
                }
                VStack(alignment: .leading) {
                    Text(advertisement.title ?? "Title not provided")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.text01!))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(PriceFormatter.formatPrice(advertisement.price ?? 0))
                        .textStyle(.body02)
                        .foregroundStyle(Color(UIColor.text02!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
