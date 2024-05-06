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
    @State private var isLiked = false
    let advertisement: Advertisement
    
    var body: some View {
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
                LikeButton(isLiked: $isLiked)
            }
        }
    }
}
