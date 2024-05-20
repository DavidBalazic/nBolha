//
//  EmptyWishlistView.swift
//  nBolha
//
//  Created by David Balažic on 18. 5. 24.
//

import SwiftUI
import NChainUI

struct EmptyWishlistView: View {
    var body: some View {
        VStack(spacing: NCConstants.Margins.large.rawValue) {
            Image(.heart)
            Text("So far, nothing has caught your eye. Why not take a look around?")
                .textStyle(.body02)
                .foregroundStyle(Color(.text02!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 36)
        }
        .padding(.top, 225)
    }
}
