//
//  ActivityIndicatorViewModifier.swift
//  nBolha
//
//  Created by David Balažic on 21. 5. 24.
//

import SwiftUI

public struct ActivityIndicatorViewModifier: ViewModifier {
    @Binding private var show: Bool

    public init(show: Binding<Bool>) {
        self._show = show
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
            ActivityIndicatorView(isShown: show)
        }
    }

}

extension View {
    public func activityIndicator(
        show: Binding<Bool>
    ) -> some View {
        modifier(
            ActivityIndicatorViewModifier(show: show)
        )
    }
}
