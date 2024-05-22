//
//  ActivityIndicatorView.swift
//  nBolha
//
//  Created by David Balažic on 21. 5. 24.
//

import SwiftUI
import Lottie

/// Lottie loader indicator view with transparent dark background for activity progress on the screen
public struct ActivityIndicatorView: View {
    public let isShown: Bool

    public init(isShown: Bool) {
        self.isShown = isShown
    }

    public var body: some View {
        ZStack {
            if isShown {
                Color.black
                    .opacity(0.6)
                LottieView(
                    animation: LottieAnimation.named("loading_animation")
                )
                .playing(loopMode: .loop)
                .frame(width: 200, height: 200)
            }
        }
        .animation(.smooth, value: isShown)
        .edgesIgnoringSafeArea(.all)
    }
}
