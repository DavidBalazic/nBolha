//
//  SwiftUICheckBox.swift
//
//
//  Created by Miha Šemrl on 30. 01. 24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SwiftUICheckBox: View {
    @Binding private var checked: Bool
    @Environment(\.isEnabled) private var isEnabled
    private let title: String
    private let text: String
    private let selectedIcon: Image
    private let unselectedIcon: Image
    private let orientation: NCConstants.ViewOrientation
    private let style: Style
    private let tapped: Action?
    
    private var iconImage: Image {
        return checked ? selectedIcon : unselectedIcon
    }
    
    public init(
        title: String,
        text: String,
        checked: Binding<Bool>,
        selectedIcon: Image? = nil,
        unselectedIcon: Image? = nil,
        orientation: NCConstants.ViewOrientation = .horizontal,
        style: Style = checkMarkDefaultStyle,
        tapped: Action? = nil
    ) {
        self.title = title
        self.text = text
        self._checked = checked
        self.selectedIcon = selectedIcon ?? Image(.icnCheckboxSelected)
        self.unselectedIcon = unselectedIcon ?? Image(.icnCheckbox)
        self.orientation = orientation
        self.style = style
        self.tapped = tapped
    }
    
    public var body: some View {
        Toggle(isOn: $checked, label: {
            Text(text)
                .textStyle(style.font)
                .foregroundStyle(isEnabled ? style.textColor : style.disabledTextColor)
        })
        .toggleStyle(
            SwiftUICheckBoxStyle(
                title: title,
                iconImage: iconImage,
                orientation: orientation,
                style: style,
                isDisabled: !isEnabled,
                tapped: tapped
            )
        )
    }
    
    public struct Style {
        var font: UIFont
        var textColor: Color
        var iconColor: Color
        var disabledTextColor: Color
        var disabledIconColor: Color
        
        public init(
            font: UIFont,
            textColor: Color,
            iconColor: Color,
            disabledTextColor: Color? = nil,
            disabledIconColor: Color? = nil
        ) {
            self.font = font
            self.textColor = textColor
            self.iconColor = iconColor
            self.disabledTextColor = disabledTextColor ?? Color(.interactionPrimaryDisabled)
            self.disabledIconColor = disabledIconColor ?? Color(.interactionPrimaryDisabled)
        }
    }
}

@available(iOS 15.0, *)
public let checkMarkDefaultStyle = SwiftUICheckBox.Style(
    font: .body02,
    textColor: Color(.brandSecondary),
    iconColor: Color(.brandSecondary)
)
