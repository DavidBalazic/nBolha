//
//  NCButtonStyle.swift
//
//
//  Created by Miha Šemrl on 12. 01. 24.
//

import SwiftUI

@available(iOS 15.0, *)
struct SwiftUIButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let style: SwiftUIButton.Style
    let buttonBadge: SwiftUIButton.ButtonBadge?
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(
        configuration: Configuration
    ) -> some View {
        let isPressed = configuration.isPressed
        configuration.label
            .foregroundStyle(
                style[.text, enabled: isEnabled, pressed: isPressed]
            )
            .background(
                style[.background, enabled: isEnabled, pressed: isPressed]
            )
            .cornerRadius(cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        style[.border, enabled: isEnabled, pressed: isPressed],
                        lineWidth: borderWidth
                    )
            }
            .overlay(alignment: buttonBadge?.alignment ?? .center) {
                buttonBadge?.badge(
                    SwiftUIButton.ButtonBadge.BadgeState(
                        isEnabled: isEnabled,
                        isPressed: isPressed
                    )
                )
            }
            .animation(.default, value: isPressed)
            .animation(.default, value: isEnabled)
            .contentShape(Rectangle())
    }
}
