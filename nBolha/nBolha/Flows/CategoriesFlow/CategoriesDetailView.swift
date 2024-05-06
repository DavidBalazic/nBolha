//
//  CategoriesDetailView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct CategoriesDetailView: View {
    @ObservedObject private var viewModel: CategoriesViewModel
    @State private var search = ""
    @State private var showSheet = false
    
    init(
        viewModel: CategoriesViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SearchBar(text: $search)
        HStack {
            Text("Home")
            Spacer()
            Button(action: {
                showSheet.toggle()
            }) {
                Image(.filter)
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
        ScrollView(showsIndicators: false) {
            if viewModel.advertisements.isEmpty {
                EmptyCategoriesView(category: "Home")
            } else {
                let pairs = viewModel.advertisements.chunked(into: 2)
                ForEach(pairs, id: \.self) { pair in
                    HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                        ForEach(pair, id: \.advertisementId) { advertisement in
                            AdvertisementItemsView(
                                likedImage: .likeBlack,
                                dislikedImage: .likeWhite,
                                advertisement: advertisement,
                                itemTapped: {
                                    viewModel.advertisementItemTapped(selectedAdvertisement: advertisement)
                                }
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
        .sheet(isPresented: $showSheet) {
            FilterView()
                .presentationDetents([.fraction(0.95)])
                .presentationDragIndicator(.hidden)
        }
    }
}
