//
//  AdvertisementDetailView.swift
//  nBolha
//
//  Created by David Balažic on 17. 4. 24.
//

import Foundation
import SwiftUI
import NChainUI

public struct DetailView: View {
    @ObservedObject private var viewModel: DetailViewModel
    @State private var showButton = false
    @State private var showTextLimit = false
    @State private var isDialogPresented = false
    
    init(
        viewModel: DetailViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                CarouselView(
                    showLikeButton: true,
                    advertisement: viewModel.advertisement,
                    likeButtonTapped: {
                        guard let advertisementId = viewModel.advertisement.advertisementId else {
                            return
                        }
                        if viewModel.advertisement.isInWishlist ?? false {
                            viewModel.dislikeAdvertisement(advertisementId: advertisementId)
                        } else {
                            viewModel.likeAdvertisement(advertisementId: advertisementId)
                        }
                    },
                    isDialogPresented: $isDialogPresented
                )
                .padding(.bottom, NCConstants.Margins.extraLarge.rawValue)
                VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                    VStack(spacing: NCConstants.Margins.large.rawValue) {
                        Text(viewModel.advertisement.title ?? "No title")
                            .textStyle(.subtitle01)
                            .foregroundStyle(Color(UIColor.text01!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Text(String(format: "%.2f €", viewModel.advertisement.price ?? "0"))
                                .textStyle(.subtitle01)
                                .foregroundStyle(Color(UIColor.text01!))
                            Spacer()
                            SwifUIChipView(
                                //TODO: wait for backend update
                                title: "Maribor",
                                size: .medium,
                                style: .init(disabledBackgroundColor: Color(.background05!), disabledBorderColor: .clear, disabledTintColor: Color(.brandSecondary!)),
                                state: .disabled,
                                leadingIcon: Image(uiImage: .mapPin)
                            )
                        }
                    }
                    VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
                        Text(viewModel.advertisement.description ?? "No description")
                            .textStyle(.body02)
                            .foregroundStyle(Color(UIColor.text01!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(showTextLimit ? 4 : nil)
                            .background(GeometryReader { geometry in
                                Color.clear.onAppear {
                                    let lines = Int(geometry.size.height / UIFont.body02.lineHeight)
                                    if lines >= 4 {
                                        showButton = true
                                        showTextLimit = true
                                    }
                                }
                            })
                        
                        if showButton {
                            Button(action: {
                                showTextLimit.toggle()
                            }) {
                                HStack {
                                    Text(showTextLimit ? "View more" : "View less")
                                        .textStyle(.subtitle03)
                                        .foregroundStyle(Color(UIColor.brandSecondary!))
                                    Image(uiImage: showTextLimit ? .chevronUp : .chevronDown)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(Color(UIColor.brandSecondary!))
                                       
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: NCConstants.Margins.huge.rawValue) {
                        HStack {
                            Text("Condition: ")
                                .textStyle(.subtitle02)
                                .foregroundStyle(Color(UIColor.text01!))
                            Text(viewModel.advertisement.condition ?? "No condition")
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
                                //TODO: implement
                            }
                        )
                        .fixedSize()
                    }
                }
                .padding(.horizontal, NCConstants.Margins.large.rawValue)
            }
            if isDialogPresented {
                CarouselViewDialog(
                    advertisement: viewModel.advertisement,
//                    likeButtonTapped: {
//                        guard let advertisementId = viewModel.advertisement.advertisementId else {
//                            return
//                        }
//                        if viewModel.advertisement.isInWishlist ?? false {
//                            viewModel.dislikeAdvertisement(advertisementId: advertisementId)
//                        } else {
//                            viewModel.likeAdvertisement(advertisementId: advertisementId)
//                        }
//                    },
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
}
