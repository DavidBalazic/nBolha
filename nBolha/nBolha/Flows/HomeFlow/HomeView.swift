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
                VStack(spacing: 20) {
                    recentlyViewed()
                    recentlyAdded()
                }
                .padding(.horizontal,  NCConstants.Margins.large.rawValue)
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    @ViewBuilder
    private func sectionHeader(title: String) -> some View {
        Text(title)
            .textStyle(.subtitle02)
            .foregroundStyle(Color(UIColor.brandTertiary!))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func recentlyViewed() -> some View {
        VStack(spacing: NCConstants.Margins.large.rawValue) {
            sectionHeader(title: "Recently viewed")
            if viewModel.advertisementRecentlyViewed.isEmpty && !viewModel.isLoading {
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
        }
    }
    
    @ViewBuilder
    private func recentlyAdded() -> some View {
        VStack(spacing: NCConstants.Margins.large.rawValue) {
            sectionHeader(title: "Recently added")
            if viewModel.advertisementRecentlyAdded.isEmpty && !viewModel.isLoading {
                EmptyRecentlyAddedView()
            } else {
                AdvertisementGridView(
                    advertisements: viewModel.advertisementRecentlyAdded,
                    itemTapped: { advertisement in
                        viewModel.advertisementItemTapped(advertisementId: advertisement.advertisementId ?? 0)
                    },
                    likeButtonTapped: { advertisement in
                        viewModel.likeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                    },
                    dislikeButtonTapped: { advertisement in
                        viewModel.dislikeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                    }
                )
            }
        }
    }
}
