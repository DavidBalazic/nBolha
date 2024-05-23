//
//  CarouselView.swift
//  nBolhaUI
//
//  Created by David Balažic on 17. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI
import nBolhaNetworking

struct CarouselView: View {
    let showLikeButton: Bool
    let advertisement: Advertisement?
    let likeButtonTapped: (() -> Void)?
    let dislikeButtonTapped: (() -> Void)?
    @State private var currentIndex = 0
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    @Binding var isDialogPresented: Bool
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                TabView(selection:$currentIndex){
                    ForEach(advertisement?.images?.indices ?? 0..<0, id: \.self){ index in
                        ZStack(alignment: .topTrailing) {
                            if let imageURL = advertisement?.images?[index].fullImageURL{
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .tag(index)
                                        .scaleEffect(currentZoom + totalZoom)
                                        .gesture(
                                            MagnificationGesture()
                                                .onChanged { value in
                                                    currentZoom = min(max( value.magnitude, 0.2), 5.0) - 1
                                                }
                                                .onEnded { value in
                                                    totalZoom += currentZoom
                                                    currentZoom = 0
                                                }
                                        )
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geometry.size.width)

                            }
                        }
                        .onTapGesture {
                            isDialogPresented = true
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onChange(of: currentIndex) { newValue in
                    currentZoom = 0
                    totalZoom = 1
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if showLikeButton, let likeButtonTapped = likeButtonTapped, let dislikeButtonTapped = dislikeButtonTapped {
                LikeButton(
                    isLiked: advertisement?.isInWishlist ?? false,
                    advertisementId: advertisement?.advertisementId ?? 0,
                    likeButtonTapped: likeButtonTapped,
                    dislikeButtonTapped: dislikeButtonTapped
                )
                .padding(.top, NCConstants.Margins.small.rawValue)
                .padding(.trailing, NCConstants.Margins.small.rawValue)
                
            }
            else {
                CloseButton() {
                    isDialogPresented = false
                }
            }
        }
        .background(.white)
        .frame(height: 300)
        .shadow(radius: 36, x: 0, y: 8)
    }
}
