//
//  SwiftUIView.swift
//  nBolha
//
//  Created by David Balažic on 10. 4. 24.
//

import SwiftUI
import NChainUI
import nBolhaNetworking
import nBolhaUI

struct RecentlyViewedView: View {
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
    
    var body: some View {
        Button(action: {
            itemTapped()
        }) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Image(.illustrations)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
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
                        likeButtonTapped: likeButtonTapped,
                        dislikeButtonTapped: dislikeButtonTapped
                    )
                }
            }
        }
    }
}
