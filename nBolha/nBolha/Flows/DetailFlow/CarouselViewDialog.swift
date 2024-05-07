//
//  CarouselView.swift
//  nBolha
//
//  Created by David Balažic on 22. 4. 24.
//

import SwiftUI
import NChainUI
import nBolhaNetworking

struct CarouselViewDialog: View {
    let advertisement: Advertisement
    @Binding var isDialogPresented: Bool
    
    var body: some View {
        ZStack {
            Color(UIColor.text01!)
                .opacity(0.7)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isDialogPresented = false
                }
            CarouselView(
                showLikeButton: false,
                advertisement: advertisement,
                likeButtonTapped: nil,
                dislikeButtonTapped: nil,
                isDialogPresented: $isDialogPresented
            )
        }
    }
}
