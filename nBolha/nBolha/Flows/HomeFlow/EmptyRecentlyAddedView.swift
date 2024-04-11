//
//  EmptyRecentlyAdded.swift
//  nBolha
//
//  Created by David Balažic on 8. 4. 24.
//

import SwiftUI
import NChainUI

struct EmptyRecentlyAddedView: View {
    var body: some View {
        VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
            Image(.illustrations3)
                .resizable()
                .scaledToFit()
                .frame(width: 154, height: 154)
            Text("It looks like there are no recently added items yet")
                .textStyle(.body02)
                .foregroundStyle(Color(UIColor.text02!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, NCConstants.Margins.extraLarge.rawValue)
        }
        .padding(.vertical, 56)
    }
}
