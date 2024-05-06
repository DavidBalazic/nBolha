//
//  CarouselView.swift
//  nBolhaUI
//
//  Created by David Balažic on 17. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct CarouselView: View {
    let images: [String] = ["Illustrations", "Illustrations2", "Illustrations3"]
    let showLikeButton: Bool
    @State private var currentIndex = 0
    @State private var isLiked = false
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
            if showLikeButton {
                LikeButton(isLiked: $isLiked, likedImage: .likeBlack, dislikedImage: .likeWhite)
                    .padding(.top, NCConstants.Margins.small.rawValue)
                    .padding(.trailing, NCConstants.Margins.small.rawValue)
            }
            else {
                CloseButton(xImage: .x) {
                    isDialogPresented = false
                }
            }
        }
        .background(.white)
        .frame(height: 300)
        .shadow(radius: 36, x: 0, y: 8)
    }
}
