//
//  CategoriesItem.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import NChainUI

struct CategoriesItemView: View {
    @ObservedObject private var viewModel: CategoriesViewModel
    private var categoryTitle: String
    private var categoryImage: UIImage
    
    init(
        viewModel: CategoriesViewModel,
        categoryTitle: String,
        categoryImage: UIImage
    ) {
        self.viewModel = viewModel
        self.categoryTitle = categoryTitle
        self.categoryImage = categoryImage
    }
    
    var body: some View {
        Button(action: {
            viewModel.categoriesItemTapped()
        }) {
            HStack {
                Text(categoryTitle)
                    .textStyle(.title06)
                    .foregroundStyle(Color(UIColor.brandTertiary!))
                    .padding(.leading, 24)
                Spacer()
                Image(uiImage: categoryImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .padding(.trailing, 24)
            }
        }
        .background(
            RoundedRectangle(
                cornerRadius: NCConstants.Radius.small.rawValue,
                style: .continuous
            )
            .stroke(Color(UIColor.outline02!), lineWidth: 1)
        )
    }
}
