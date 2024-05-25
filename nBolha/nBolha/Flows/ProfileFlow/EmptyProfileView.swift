//
//  EmptyProfileView.swift
//  nBolha
//
//  Created by David Balažic on 21. 5. 24.
//

import SwiftUI
import NChainUI

struct EmptyProfileView: View {
    var body: some View {
        VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
            Image(.illustrations3)
                .resizable()
                .scaledToFit()
                .frame(width: 154, height: 154)
            Text("You haven't posted any listings, add some!")
                .textStyle(.body02)
                .foregroundStyle(Color(UIColor.text02!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, NCConstants.Margins.extraLarge.rawValue)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 56)
        .padding(.top, 32)
    }
}
