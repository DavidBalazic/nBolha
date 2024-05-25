//
//  AdvertisementDetailView.swift
//  nBolha
//
//  Created by David Balažic on 17. 4. 24.
//

import Foundation
import SwiftUI
import NChainUI
import nBolhaUI

public struct DetailView: View {
    @ObservedObject private var viewModel: DetailViewModel
    @State private var isDialogPresented = false
    
    init(
        viewModel: DetailViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                    CarouselView(
                        showLikeButton: true,
                        advertisement: viewModel.advertisement,
                        likeButtonTapped: {
                            viewModel.likeAdvertisementTapped(advertisementId: viewModel.advertisement?.advertisementId ?? 0)
                        },
                        dislikeButtonTapped: {
                            viewModel.dislikeAdvertisementTapped(advertisementId: viewModel.advertisement?.advertisementId ?? 0)
                        },
                        isDialogPresented: $isDialogPresented
                    )
                    VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                        advertisementDetails()
                        descriptionSection()
                        conditionSection()
                    }
                    .padding(.horizontal, NCConstants.Margins.large.rawValue)
                }
                
            }
            if isDialogPresented {
                CarouselViewDialog(
                    advertisement: viewModel.advertisement,
                    isDialogPresented: $isDialogPresented
                )
                .onAppear {
                    viewModel.disableNavigations()
                }
                .onDisappear {
                    viewModel.enableNavigations()
                }
            }
        }
    }
    
    @ViewBuilder
    private func advertisementDetails() -> some View {
        VStack(spacing: NCConstants.Margins.large.rawValue) {
            Text(viewModel.advertisement?.title ?? "No title")
                .textStyle(.subtitle01)
                .foregroundStyle(Color(UIColor.text01!))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(PriceFormatter.formatPrice(viewModel.advertisement?.price ?? 0))
                    .textStyle(.subtitle01)
                    .foregroundStyle(Color(UIColor.text01!))
                Spacer()
                SwifUIChipView(
                    title: viewModel.advertisement?.address ?? "No address",
                    size: .medium,
                    style: .init(disabledBackgroundColor: Color(.background05!), disabledBorderColor: .clear, disabledTintColor: Color(.brandSecondary!)),
                    state: .disabled,
                    leadingIcon: Image(uiImage: .mapPin)
                )
            }
        }
    }
    
    @ViewBuilder
    private func descriptionSection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
            Text(viewModel.advertisement?.description ?? "No description")
                .textStyle(.body02)
                .foregroundStyle(Color(UIColor.text01!))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(viewModel.shouldShowTextLimit ? 4 : nil)
            
            if viewModel.showButton {
                Button(action: {
                    viewModel.toggleTextLimit()
                }) {
                    HStack {
                        Text(viewModel.shouldShowTextLimit ? "View more" : "View less")
                            .textStyle(.subtitle03)
                            .foregroundStyle(Color(UIColor.brandSecondary!))
                        Image(uiImage: viewModel.shouldShowTextLimit ? .chevronDown : .chevronUp)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color(UIColor.brandSecondary!))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func conditionSection() -> some View {
        VStack(spacing: NCConstants.Margins.huge.rawValue) {
            HStack {
                Text("Condition: ")
                    .textStyle(.subtitle02)
                    .foregroundStyle(Color(UIColor.text01!))
                Text(viewModel.advertisement?.condition ?? "No condition")
                    .textStyle(.body02)
                    .foregroundStyle(Color(UIColor.text01!))
                Spacer()
            }
            SwiftUIButton(
                text: "Contact seller",
                leadingIcon:  SwiftUIButton.ButtonIcon.init(
                    image: Image(uiImage: .envelope),
                    size: .large
                ),
                tapped: {
                    viewModel.contactSellerTapped()
                }
            )
            .fixedSize()
        }
    }
}
