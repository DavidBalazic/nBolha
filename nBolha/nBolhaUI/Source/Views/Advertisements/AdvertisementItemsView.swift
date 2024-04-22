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
    @State private var isLiked = false
    let likedImage: UIImage
    let dislikedImage: UIImage
    let advertisement: Advertisement
    
    public init(
        likedImage: UIImage,
        dislikedImage: UIImage,
        advertisement: Advertisement
    ) {
        self.likedImage = likedImage
        self.dislikedImage = dislikedImage
        self.advertisement = advertisement
    }
    
    public var body: some View {
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
                LikeButton(isLiked: $isLiked, likedImage: likedImage, dislikedImage: dislikedImage)
            }
            VStack () {
                Text(advertisement.title ?? "Title not provided")
                    .textStyle(.subtitle02)
                    .foregroundStyle(Color(UIColor.text01!))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(String(format: "%.2f€", advertisement.price ?? "0"))
                    .textStyle(.body02)
                    .foregroundStyle(Color(UIColor.text02!))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}