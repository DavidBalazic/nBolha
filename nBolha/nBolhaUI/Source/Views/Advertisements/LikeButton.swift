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
    
    public init(
        isLiked: Bool,
        advertisementId: Int,
        likeButtonTapped: @escaping () -> Void
    ) {
        self.isLiked = isLiked
        self.advertisementId = advertisementId
        self.likeButtonTapped = likeButtonTapped
    }
    
    public var body: some View {
        Button(action: {
            likeButtonTapped()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: NCConstants.Margins.extraLarge.rawValue, height: NCConstants.Margins.extraLarge.rawValue)
                    .shadow(radius: 36, x: 0, y: NCConstants.Margins.small.rawValue)
                Image(uiImage: isLiked ? .likeBlack : .likeWhite)
            }
        }
        .padding(.top, NCConstants.Margins.small.rawValue)
        .padding(.trailing, NCConstants.Margins.small.rawValue)
    }
}
