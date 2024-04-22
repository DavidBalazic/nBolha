//
//  EmptyCategoriesView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import NChainUI

struct EmptyCategoriesView: View {
    private let category: String
    
    public init(
        category: String
    ) {
        self.category = category
    }
    
    var body: some View {
        VStack(spacing: NCConstants.Margins.extraGiant.rawValue) {
            Text(category)
                .textStyle(.subtitle02)
                .foregroundStyle(Color(UIColor.brandTertiary!))
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                Image(.illustrations4)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                Text("This category is currently empty. Browse other categories to view available items.")
                    .textStyle(.body02)
                    .foregroundStyle(Color(UIColor.text02!))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, NCConstants.Margins.huge.rawValue)
                SwiftUIButton(
                    text: "Browse categories",
                    trailingIcon: SwiftUIButton.ButtonIcon.init(
                        image: Image(.arrow),
                        size: .large
                    ),
                    style: .outlined,
                    size: .small,
                    tapped: tapped
                )
                .fixedSize()
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
    }
}

func tapped() {
    //TODO: implement
}
