//
//  EmptyCategoriesView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import NChainUI

struct EmptyCategoriesView: View {
    let browseCategoriesTapped: () -> Void
    
    init(
        browseCategoriesTapped: @escaping () -> Void
    ) {
        self.browseCategoriesTapped = browseCategoriesTapped
    }
    
    var body: some View {
        VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
            Image(.illustrations4)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("This category is currently empty. Browse other categories to view available items.")
                .textStyle(.body02)
                .foregroundStyle(Color(UIColor.text02!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
            SwiftUIButton(
                text: "Browse categories",
                trailingIcon: SwiftUIButton.ButtonIcon.init(
                    image: Image(.arrow),
                    size: .large
                ),
                style: .outlined,
                size: .small,
                tapped: browseCategoriesTapped
            )
            .fixedSize()
        }
        .padding(.top, 85)
    }
}
