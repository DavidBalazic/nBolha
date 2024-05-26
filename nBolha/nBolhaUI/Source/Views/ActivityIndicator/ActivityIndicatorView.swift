//
//  ActivityIndicatorView.swift
//  nBolha
//
//  Created by David Balažic on 21. 5. 24.
//

import SwiftUI
import Lottie

public struct ActivityIndicatorView: View {
    public let isShown: Bool

    public init(isShown: Bool) {
        self.isShown = isShown
    }

    public var body: some View {
        ZStack {
            if isShown {
                Color.white
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
