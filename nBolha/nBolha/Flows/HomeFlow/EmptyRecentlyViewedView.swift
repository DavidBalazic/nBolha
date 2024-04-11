//
//  EmptyRecentlyViewed.swift
//  nBolha
//
//  Created by David Balažic on 8. 4. 24.
//

import SwiftUI
import NChainUI

struct EmptyRecentlyViewedView: View {
    var viewModel: HomeViewModel
    
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
            Text("No items viewed yet. Start browsing to see your recently viewed items here!")
                .textStyle(.body02)
                .foregroundStyle(Color(UIColor.text02!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, NCConstants.Margins.extraLarge.rawValue)
            SwiftUIButton(
                text: "Start exploring",
                trailingIcon: SwiftUIButton.ButtonIcon.init(
                    image: Image(.arrow),
                    size: .large
                ),
                style: .outlined,
                size: .small,
                tapped: viewModel.startExploringTapped
            )
            .fixedSize()
        }
        .padding(.vertical, 56)
    }
}
