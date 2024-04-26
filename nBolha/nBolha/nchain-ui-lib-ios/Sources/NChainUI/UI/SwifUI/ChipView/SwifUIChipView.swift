//
//  SwifUIChipView.swift
//
//
//  Created by Miha Šemrl on 18. 01. 24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SwifUIChipView: View {
    private let title: String
    private let size: Size
    private let style: ChipViewStyle
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let tapped: Action?
    private let trailingIconTapped: Action?
    @State public var state: SwifUIChipView.ChipState
    
    private var tintColor: Color {
        switch state {
        case .selected:
            return style.selectedTintColor
        case .unselected:
            return style.unselectedTintColor
        case .disabled:
            return style.disabledTintColor
        }
    }
    
    private var borderColor: Color {
        switch state {
        case .selected:
            return style.selectedBorderColor
        case .unselected:
            return style.unselectedBorderColor
        case .disabled:
            return style.disabledBorderColor
        }
    }
    
    private var backgroundColor: Color {
        switch state {
        case .selected:
            return style.selectedBackgroundColor
        case .unselected:
            return style.unselectedBackgroundColor
        case .disabled:
            return style.disabledBackgroundColor
        }
    }

    public init(
        title: String,
        size: SwifUIChipView.Size,
        style: ChipViewStyle = chipViewDefaultStyle,
        state: SwifUIChipView.ChipState = .unselected,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        tapped: Action? = nil,
        trailingIconTapped: Action? = nil
    ) {
        self.title = title
        self.size = size
        self.style = style
        self.state = state
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.tapped = tapped
        self.trailingIconTapped = trailingIconTapped
    }

    public var body: some View {
        HStack(
            alignment: .center,
            spacing: NCConstants.Margins.extraSmall.rawValue
        ) {
            leadingIcon?
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    maxWidth: size.iconSize,
                    maxHeight: size.iconSize
                )
                .foregroundColor(tintColor)
            Text(title)
                .textStyle(size.font)
                .foregroundStyle(tintColor)
                .padding(.vertical, NCConstants.Margins.extraSmall.rawValue + size.vPadding)
                
            trailingIcon?
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    maxWidth: size.iconSize,
                    maxHeight: size.iconSize
                )
                .foregroundColor(tintColor)
                .onTapGesture {
                    trailingIconTapped?()
                }
        }
        .padding(.horizontal, size.hPadding)
        .background {
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .fill(backgroundColor)
        }
        .overlay {
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .stroke(borderColor)
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    guard state != .disabled else { return }
                    state = state == .selected ? .unselected : .selected
                    tapped?()
                }
        )
    }

    public enum Size: CaseIterable {
        case small
        case medium

        var font: UIFont {
            switch self {
            case .small:
                return .caption03
            case .medium:
                return .subtitle03
            }
        }

        var hPadding: CGFloat {
            switch self {
            case .small:
                return 8.5
            case .medium:
                return 12.5
            }
        }

        // To deduce the final value of the padding, we
        // take the font, extract it's lineHeight (which is
        // less than as defined on Figma), and add it as
        // vertical padding.
        var vPadding: CGFloat {
            abs(expectedLineHeight - font.lineHeight) / 2
        }

        var cornerRadius: CGFloat {
            switch self {
            case .small:
                return NCConstants.Radius.small.rawValue
            case .medium:
                return NCConstants.Radius.medium.rawValue
            }
        }

        // Figma defines the line height differently
        // that we get in iOS, so we need to take it into
        // account when defining the padding for the view.
        private var expectedLineHeight: CGFloat {
            switch self {
            case .small:
                return 12
            case .medium:
                return 20
            }
        }
        
        var iconSize: CGFloat {
            switch self {
            case .small:
                return NCConstants.IconSize.small.rawValue
            case .medium:
                return NCConstants.IconSize.medium.rawValue
            }
        }
    }
    
    public enum ChipState {
        case selected
        case unselected
        case disabled
    }
}
