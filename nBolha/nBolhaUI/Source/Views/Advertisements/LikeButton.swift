//
//  LikeButton.swift
//  nBolhaUI
//
//  Created by David Balažic on 10. 4. 24.
//

import SwiftUI
import NChainUI
import nBolhaNetworking

public struct LikeButton: View {
    let isLiked: Bool
    let advertisementId: Int
    let likeButtonTapped: () -> Void
    let dislikeButtonTapped: () -> Void
    
    public init(
        isLiked: Bool,
        advertisementId: Int,
        likeButtonTapped: @escaping () -> Void,
        dislikeButtonTapped: @escaping () -> Void
    ) {
        self.isLiked = isLiked
        self.advertisementId = advertisementId
        self.likeButtonTapped = likeButtonTapped
        self.dislikeButtonTapped = dislikeButtonTapped
    }
    
    public var body: some View {
        Button(action: {
            if !isLiked {
                likeButtonTapped()
            } else {
                dislikeButtonTapped()
            }
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: NCConstants.Margins.extraLarge.rawValue, height: NCConstants.Margins.extraLarge.rawValue)
                    .shadow(radius: 36, x: 0, y: NCConstants.Margins.small.rawValue)
                Image(uiImage: isLiked ? .likeBlack : .likeWhite)
            }
            .padding(8)
        }
    }
}
