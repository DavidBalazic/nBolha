//
//  HomeView.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import SwiftUI
import NChainUI
import nBolhaUI

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.search, isEditing: $viewModel.isEditing)
                .submitLabel(.search)
                .onSubmit {
                    viewModel.applySearchTapped(search: viewModel.search)
                }
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Recently viewed")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.brandTertiary!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if viewModel.advertisementRecentlyViewed.isEmpty {
                        EmptyRecentlyViewedView(viewModel: viewModel)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: NCConstants.Margins.large.rawValue) {
                                ForEach(viewModel.advertisementRecentlyViewed, id: \.advertisementId) { advertisement in
                                    RecentlyViewedView(
                                        advertisement: advertisement,
                                        itemTapped: {
                                            viewModel.advertisementItemTapped(advertisementId: advertisement.advertisementId ?? 0)
                                        },
                                        likeButtonTapped: {
                                            viewModel.likeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                        },
                                        dislikeButtonTapped: {
                                            viewModel.dislikeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                        }
                                    )
                                }
                            }
                        }
                    }
                    Text("Recently added")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.brandTertiary!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if viewModel.advertisementRecentlyAdded.isEmpty {
                        EmptyRecentlyAddedView()
                    } else {
                        let pairs = viewModel.advertisementRecentlyAdded.chunked(into: 2)
                        ForEach(pairs, id: \.self) { pair in
                            HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                                ForEach(pair, id: \.advertisementId) { advertisement in
                                    AdvertisementItemsView(
                                        advertisement: advertisement,
                                        itemTapped: {
                                            viewModel.advertisementItemTapped(advertisementId: advertisement.advertisementId ?? 0)
                                        },
                                        likeButtonTapped: {
                                            viewModel.likeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                        },
                                        dislikeButtonTapped: {
                                            viewModel.dislikeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
            .onAppear {
                Task {
                    await viewModel.loadRecentlyViewed()
                    await viewModel.loadRecentlyAdded()
                }
            }
        }
    }
}
