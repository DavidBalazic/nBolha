//
//  SwiftUICheckBoxStyle.swift
//
//
//  Created by Miha Šemrl on 5. 02. 24.
//

import SwiftUI

@available(iOS 15.0, *)
struct SwiftUICheckBoxStyle: ToggleStyle {
    let title: String
    let iconImage: Image
    let orientation: NCConstants.ViewOrientation
    let style: SwiftUICheckBox.Style
    let isDisabled: Bool
    let tapped: Action?
    let isChecked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Button (action: {
            tapped?()
            configuration.isOn.toggle()},
                label: {
            if orientation == .horizontal {
                HStack(
                    alignment: .center,
                    spacing: NCConstants.Margins.small.rawValue
                ) {
                    iconImage
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            maxWidth: NCConstants.IconSize.huge.rawValue,
                            maxHeight: NCConstants.IconSize.huge.rawValue
                        )
                        .foregroundColor(isChecked ? style.disabledIconColor : style.iconColor)
                    VStack(alignment: .leading) {
                        Text(title)
                            .textStyle(.subtitle02)
                            .foregroundStyle(Color(.text01!))
                        configuration.label
                            .multilineTextAlignment(.leading)
                    }
                }
            } else {
                VStack(
                    alignment: .center,
                    spacing: NCConstants.Margins.small.rawValue
                ) {
                    configuration.label
                    iconImage
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            maxWidth: NCConstants.IconSize.huge.rawValue,
                            maxHeight: NCConstants.IconSize.huge.rawValue
                        )
                        .foregroundColor(isDisabled ? style.disabledIconColor : style.iconColor)
                }
            }
        })
    }
}
