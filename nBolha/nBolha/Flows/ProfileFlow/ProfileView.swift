//
//  ProfileView.swift
//  nBolha
//
//  Created by David Balažic on 17. 5. 24.
//

import SwiftUI
import NChainUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject private var viewModel: ProfileViewModel
    @State private var showDeleteAlert = false
    
    init(
        viewModel: ProfileViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: NCConstants.Margins.large.rawValue) {
                profileContent()
                listingsContent()
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
        }
        .activityIndicator(show: $viewModel.isLoading)
        .onAppear {
            viewModel.onAppear()
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete item"),
                message: Text("Are you sure you want to delete this item?"),
                primaryButton: .destructive(Text("Delete")) {
                    Task { await viewModel.deleteAdvertisementTapped() }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    @ViewBuilder
    private func profileContent() -> some View {
        HStack(spacing: NCConstants.Margins.large.rawValue) {
            PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                AsyncImage(url: viewModel.profile?.fullImageURL) { phase in
                    switch phase {
                    case .empty:
                        if viewModel.profile?.imageAddress == nil {
                            Image(.defaultProfile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(.defaultProfile)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 96, height: 96)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(UIColor.brandSecondary!), lineWidth: 3))
            }
            VStack(alignment: .leading, spacing: NCConstants.Margins.large.rawValue) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.profile?.name ?? "jane Doe")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.text01!))
                    Text(viewModel.profile?.username ?? "Jane.Doe@nChain.com")
                        .textStyle(.body03)
                        .foregroundStyle(Color(UIColor.text01!))
                }
                HStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                    Text("\(viewModel.profileAdvertisements.count) listings")
                        .textStyle(.body02)
                        .foregroundStyle(Color(UIColor.text02!))
                    SwifUIChipView(
                        title: viewModel.profile?.location ?? "Other",
                        size: .medium,
                        style: .init(disabledBackgroundColor: Color(.background05!), disabledBorderColor: .clear, disabledTintColor: Color(.brandSecondary!)),
                        state: .disabled,
                        leadingIcon: Image(uiImage: .mapPin)
                    )
                }
            }
        }
        .padding(.bottom, NCConstants.Margins.large.rawValue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func listingsContent() -> some View {
        Text("My listings")
            .textStyle(.subtitle02)
            .foregroundStyle(Color(UIColor.text01!))
            .frame(maxWidth: .infinity, alignment: .leading)
        if viewModel.profileAdvertisements.isEmpty && !viewModel.isLoading {
            EmptyProfileView()
        }
        else {
            let pairs = viewModel.profileAdvertisements.chunked(into: 2)
            ForEach(pairs, id: \.self) { pair in
                HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                    ForEach(pair, id: \.advertisementId) { advertisement in
                        ProfileAdvertisementsView(
                            advertisement: advertisement,
                            itemTapped: {
                                viewModel.advertisementItemTapped(advertisementId: advertisement.advertisementId ?? 0)
                            }, deleteItemTapped: {
                                viewModel.setAdvertisementToDelete(advertisement)
                                showDeleteAlert = true
                            }
                        )
                    }
                    if pair.count == 1 {
                        Spacer().frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}
