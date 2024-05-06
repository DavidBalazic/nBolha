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
    
    public init(
        advertisement: Advertisement,
        itemTapped: @escaping () -> Void,
        likeButtonTapped: @escaping () -> Void
    ) {
        self.advertisement = advertisement
        self.itemTapped = itemTapped
        self.likeButtonTapped = likeButtonTapped
    }
    
    public var body: some View {
        Button(action: {
            itemTapped()
        }) {
            VStack(spacing: NCConstants.Margins.small.rawValue) {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: .checkmark)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(
                            RoundedRectangle(
                                cornerRadius: NCConstants.Radius.small.rawValue,
                                style: .continuous
                            )
                            .stroke(Color(UIColor.outline02!), lineWidth: 1)
                        )
                    LikeButton(
                        isLiked: advertisement.isInWishlist ?? false,
                        advertisementId: advertisement.advertisementId ?? 0,
                        likeButtonTapped: likeButtonTapped
                    )
                }
                VStack () {
                    Text(advertisement.title ?? "Title not provided")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.text01!))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(String(format: "%.2f €", advertisement.price ?? "0"))
                        .textStyle(.body02)
                        .foregroundStyle(Color(UIColor.text02!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
