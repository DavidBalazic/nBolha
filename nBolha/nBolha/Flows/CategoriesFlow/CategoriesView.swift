//
//  CategoriesView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct CategoriesView: View {
    @ObservedObject private var viewModel: CategoriesViewModel
    @State private var search = ""
    
    init(
        viewModel: CategoriesViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $search)
            ScrollView(showsIndicators: false) {
                VStack(spacing: NCConstants.Margins.large.rawValue) {
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Home", categoryImage: .homeCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Construction", categoryImage: .constructionCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Automotive", categoryImage: .automotiveCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Sport", categoryImage: .sportCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Audiovisual", categoryImage: .audiovisualCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Literature", categoryImage: .literatureCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Hobbies", categoryImage: .hobbiesCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Apparel", categoryImage: .apparelCategory)
                    CategoriesItemView(viewModel: viewModel, categoryTitle: "Services", categoryImage: .servicesCategory)
                }
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
        }
    }
}
