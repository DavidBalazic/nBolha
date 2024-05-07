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
    let images: [String] = ["Illustrations", "Illustrations2", "Illustrations3"]
    let showLikeButton: Bool
    let advertisement: Advertisement
    let likeButtonTapped: (() -> Void)?
    let dislikeButtonTapped: (() -> Void)?
    @State private var currentIndex = 0
    @Binding var isDialogPresented: Bool
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                TabView(selection:$currentIndex){
                    ForEach(0..<images.count,id: \.self){ imageIndex in
                        ZStack(alignment: .topTrailing) {
                            Image(images[imageIndex])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width)
                                .tag(imageIndex)
                        }
                        .onTapGesture {
                            isDialogPresented = true
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
        .overlay(alignment: .topTrailing) {
            if showLikeButton, let likeButtonTapped = likeButtonTapped, let dislikeButtonTapped = dislikeButtonTapped {
                LikeButton(
                    isLiked: advertisement.isInWishlist ?? false,
                    advertisementId: advertisement.advertisementId ?? 0,
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
