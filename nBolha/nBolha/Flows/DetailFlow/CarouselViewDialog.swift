//
//  CarouselView.swift
//  nBolha
//
//  Created by David Balažic on 22. 4. 24.
//

import SwiftUI
import NChainUI

struct CarouselViewDialog: View {
    @Binding var isDialogPresented: Bool
    
    var body: some View {
        ZStack {
            Color(UIColor.text01!)
                .opacity(0.7)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isDialogPresented = false
                }
            CarouselView(showLikeButton: false, isDialogPresented: $isDialogPresented)
        }
    }
}
