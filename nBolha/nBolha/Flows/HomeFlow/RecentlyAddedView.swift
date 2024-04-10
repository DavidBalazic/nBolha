//
//  RecentlyAddedView.swift
//  nBolha
//
//  Created by David Balažic on 10. 4. 24.
//

import SwiftUI
import nBolhaNetworking
import NChainUI
import nBolhaUI

struct RecentlyAddedView: View {
    @State private var isLiked = false
    let advertisement: Advertisement
    
    var body: some View {
        VStack(spacing: NCConstants.Margins.small.rawValue) {
            ZStack(alignment: .topTrailing) {
                Image(.illustrations3)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 163, height: 163)
                    .background(
                        RoundedRectangle(
                            cornerRadius: NCConstants.Radius.small.rawValue,
                            style: .continuous
                        )
                        .stroke(Color(UIColor.outline02!), lineWidth: 1)
                    )
                LikeButton(isLiked: $isLiked, likedImage: .likeBlack, unLikedImage: .likeWhite)
            }
            VStack () {
                Text(advertisement.title ?? "Ni opisa")
                    .textStyle(.subtitle02)
                    .foregroundStyle(Color(UIColor.text01!))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(String(format: "%.2f€", advertisement.price ?? "Po dogovoru"))
                    .textStyle(.body02)
                    .foregroundStyle(Color(UIColor.text02!))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
