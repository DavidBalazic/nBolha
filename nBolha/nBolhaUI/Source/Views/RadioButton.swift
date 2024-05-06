//
//  RadioButton.swift
//  nBolhaUI
//
//  Created by David Balažic on 24. 4. 24.
//

import SwiftUI
import NChainUI

public struct RadioButton: View {
    @Binding private var isSelected: Bool
    private let label: String
    @State private var animate: Bool = false
    
    public init(isSelected: Binding<Bool>, label: String = "") {
        self._isSelected = isSelected
        self.label = label
    }
    
    public init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "") {
        self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set: { _ in selection.wrappedValue = tag }
        )
        self.label = label
    }
    
    public var body: some View {
        HStack(spacing: NCConstants.Margins.large.rawValue) {
            circleView
            labelView
        }
        .contentShape(Rectangle())
        .onTapGesture { isSelected = true }
    }
}

struct AnimationProperties {
    var scaleValue: CGFloat = 1.0
}

private extension RadioButton {
    @ViewBuilder var labelView: some View {
        if !label.isEmpty {
            Text(label)
                .textStyle(.subtitle02)
                .foregroundStyle(Color(UIColor.text01!))
        }
    }
    
    @ViewBuilder var circleView: some View {
        Circle()
            .fill(innerCircleColor)
            .animation(.easeInOut(duration: 0.15), value: isSelected)
            .padding(4)
            .overlay(
                Circle()
                    .stroke(outlineColor, lineWidth: 2)
            )
            .frame(width: 20, height: 20)
            .keyframeAnimator(
                initialValue: AnimationProperties(), trigger: animate,
                content: { content, value in
                    content
                        .scaleEffect(value.scaleValue)
                },
                keyframes: { _ in
                    KeyframeTrack(\.scaleValue) {
                        CubicKeyframe(0.9, duration: 0.05)
                        CubicKeyframe(1.10, duration: 0.15)
                        CubicKeyframe(1, duration: 0.25)
                    }
                })
            .onChange(of: isSelected) { _, newValue in
                if newValue == true {
                    animate.toggle()
                }
            }
    }
}


private extension RadioButton {
    var innerCircleColor: Color {
        return isSelected ? Color(UIColor.brandSecondary!) : Color.clear
    }
    
    var outlineColor: Color {
        return isSelected ? Color(UIColor.brandSecondary!) : Color(UIColor.icons03!)
    }
}
