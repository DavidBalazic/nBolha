//
//  NCButtonUI.swift
//
//
//  Created by Miha Šemrl on 12. 01. 24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SwiftUIButton: View {
    private let text: String?
    private let leadingIcon: ButtonIcon?
    private let trailingIcon: ButtonIcon?
    private let style: Style
    private let size: Size
    private let tapped: Action
    private let isExpanded: Bool
    private let buttonBadge: ButtonBadge?
    
    public init(
        text: String? = nil,
        leadingIcon: ButtonIcon? = nil,
        trailingIcon: ButtonIcon? = nil,
        style: Style = .primary,
        size: Size = .regular,
        expandWidth: Bool = true,
        buttonBadge: ButtonBadge? = nil,
        tapped: @escaping Action
    ) {
        self.text = text
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.style = style
        self.size = size
        self.isExpanded = expandWidth
        self.buttonBadge = buttonBadge
        self.tapped = tapped
    }
    
    public var body: some View {
        Button(
            action: tapped,
            label: {
                HStack(
                    alignment: .center,
                    spacing: NCConstants.Margins.small.rawValue
                ) {
                    leadingIcon?.image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            maxWidth: leadingIcon?.size.size.width,
                            maxHeight: leadingIcon?.size.size.height
                        )
                    
                    if let text {
                        Text(text)
                            .textStyle(size.font)
                            .underline(style.underlined)
                    }
                    
                    trailingIcon?.image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            maxWidth: trailingIcon?.size.size.width,
                            maxHeight: trailingIcon?.size.size.height
                        )
                }
                .frame(maxWidth: isExpanded ? .infinity : nil)
                .frame(height: size.height)
                .padding(.horizontal, size.hPadding)
            }
        )
        .buttonStyle(
            SwiftUIButtonStyle(
                cornerRadius: size.cornerRadius,
                borderWidth: size.borderWidth,
                style: style,
                buttonBadge: buttonBadge
            )
        )
    }
    
    public struct Style {
        let underlined: Bool
        private var colors = Set<ButtonColor>()
        
        public init(underlined: Bool = false) {
            self.underlined = underlined
        }
        
        public static var primary: Style {
            Style()
                .update(.background, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.background, enabled: true, pressed: false, color: Color(.brandPrimary))
                .update(.background, enabled: true, pressed: true, color: Color(.contrast03))
                .update(.text, pressed: false, color: Color(.inverseText01))
                .update(.text, pressed: true, color: Color(.brandTertiary))
        }
        
        public static var outlined: Style {
            Style()
                .update(.text, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.text, enabled: true, pressed: false, color: Color(.brandPrimary))
                .update(.text, enabled: true, pressed: true, color: Color(.brandTertiary))
                .update(.border, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.border, enabled: true, pressed: false, color: Color(.brandPrimary))
                .update(.border, enabled: true, pressed: true, color: Color(.interactionPrimaryFocus))
        }
        
        public static var text: Style {
            Style()
                .update(.text, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.text, enabled: true, pressed: false, color: Color(.brandPrimary))
                .update(.text, enabled: true, pressed: true, color: Color(.brandTertiary))
                .update(.border, pressed: true, color: Color(.interactionPrimaryFocus))
        }
        
        public static var underlined: Style {
            Style(underlined: true)
                .update(.text, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.text, enabled: true, pressed: false, color: Color(.brandPrimary))
                .update(.text, enabled: true, pressed: true, color: Color(.brandTertiary))
        }
        
        public static var destructive: Style {
            Style()
                .update(.text, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.text, enabled: true, color: Color(.errorDefault))
                .update(.border, pressed: true, color: Color(.errorDefault))
        }
        
        public static var destructiveOutlined: Style {
            Style()
                .update(.text, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.text, enabled: true, color: Color(.errorDefault))
                .update(.border, enabled: false, color: Color(.interactionPrimaryDisabled))
                .update(.border, enabled: true, color: Color(.errorDefault))
        }
        
        public func update(
            _ type: ButtonColorType,
            enabled: Bool? = nil,
            pressed: Bool? = nil,
            color: Color
        ) -> Self {
            var mutableSelf = self
            mutableSelf[type, enabled: enabled, pressed: pressed] = color
            return mutableSelf
        }
        
        public subscript(
            type: ButtonColorType,
            enabled enabled: Bool? = nil,
            pressed pressed: Bool? = nil
        ) -> Color {
            get {
                colors
                    .filter {
                        $0.type == type
                    }
                    .filter {
                        $0.pressed == pressed || $0.pressed == nil || pressed == nil
                    }
                    .filter {
                        $0.enabled == enabled || $0.enabled == nil || enabled == nil
                    }
                    .first?.color ?? .clear
            }
            set {
                colors.update(
                    with: ButtonColor(
                        color: newValue,
                        type: type,
                        pressed: pressed,
                        enabled: enabled
                    )
                )
            }
        }

        public enum ButtonColorType {
            case background
            case border
            case text
        }
        
        private struct ButtonColor: Hashable {
            let color: Color
            let type: ButtonColorType
            let pressed: Bool?
            let enabled: Bool?
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(type)
                hasher.combine(pressed)
                hasher.combine(enabled)
            }
            
            static func ==(lhs: ButtonColor, rhs: ButtonColor) -> Bool {
                lhs.type == rhs.type &&
                lhs.pressed == rhs.pressed &&
                lhs.enabled == rhs.enabled
            }
        }
    }
    
    public struct Size {
        public static let regular = Size(
            font: .subtitle02,
            height: NCConstants.ButtonHeight.default.rawValue,
            hPadding: NCConstants.Margins.extraLarge.rawValue
        )
        
        public static let small = Size(
            font: .subtitle03,
            height: NCConstants.ButtonHeight.small.rawValue,
            hPadding: NCConstants.Margins.medium.rawValue
        )
        
        let font: UIFont
        let height: CGFloat
        let hPadding: CGFloat
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        
        public init(
            font: UIFont,
            height: CGFloat,
            hPadding: CGFloat,
            cornerRadius: CGFloat = NCConstants.Radius.small.rawValue,
            borderWidth: CGFloat = 1
        ) {
            self.font = font
            self.height = height
            self.hPadding = hPadding
            self.cornerRadius = cornerRadius
            self.borderWidth = borderWidth
        }
    }
    
    public enum ImageSize {
        /// 12x12
        case small
        /// 16x16
        case medium
        /// 18x18
        case large
        /// 24x24
        case huge
        
        var size: CGSize {
            switch self {
            case .small:
                return CGSize(width: NCConstants.IconSize.small.rawValue, height: NCConstants.IconSize.small.rawValue)
            case .medium:
                return CGSize(width: NCConstants.IconSize.medium.rawValue, height: NCConstants.IconSize.medium.rawValue)
            case .large:
                return CGSize(width: NCConstants.IconSize.large.rawValue, height: NCConstants.IconSize.large.rawValue)
            case .huge:
                return CGSize(width: NCConstants.IconSize.huge.rawValue, height: NCConstants.IconSize.huge.rawValue)
            }
        }
    }
    
    public struct ButtonIcon {
        let image: Image
        let size: ImageSize
        
        public init(
            image: Image,
            size: ImageSize
        ) {
            self.image = image
            self.size = size
        }
    }
    
    public struct ButtonBadge {
        public typealias BadgeBuilder = (BadgeState) -> AnyView
        
        public struct BadgeState {
            public let isEnabled: Bool
            public let isPressed: Bool
        }
        
        let alignment: Alignment
        let badge: BadgeBuilder
        
        public init(
            alignment: Alignment,
            @ViewBuilder badge: @escaping BadgeBuilder
        ) {
            self.alignment = alignment
            self.badge = badge
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    UIFont.registerFonts()
    
    let disabled = false
    
    return ScrollView {
        VStack {
            SwiftUIButton(
                text: "Primary button",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .primary,
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
            
            SwiftUIButton(
                text: "Outlined button - clear",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .outlined,
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
            
            SwiftUIButton(
                text: "Outlined button - white",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .outlined.update(.background, color: .white),
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
            
            SwiftUIButton(
                text: "Text button",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .text,
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
            
            SwiftUIButton(
                text: "Underlined button",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .underlined,
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
            
            SwiftUIButton(
                text: "Destructive button",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .destructive,
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
            
            SwiftUIButton(
                text: "Destructive outlined button",
                leadingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                trailingIcon: SwiftUIButton.ButtonIcon(
                    image: Image(.icnEye),
                    size: .huge
                ),
                style: .destructiveOutlined,
                size: .regular,
                expandWidth: true,
                buttonBadge: nil,
                tapped: {}
            )
        }
        .disabled(disabled)
        .padding()
    }
    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
}
