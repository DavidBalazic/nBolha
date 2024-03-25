//
//  SwiftUINotificationStyle.swift
//
//
//  Created by Miha Šemrl on 28. 02. 24.
//

import SwiftUI

public enum NotificationStyle: Equatable {
    case error
    case success
    case info
    case custom(NotificationStyleConfiguration)
    
    public var config: NotificationStyleConfiguration {
        switch self {
        case .error:
            return .init(
                themeColor: Color(.inverseError),
                icon: Image(.icnAlert),
                titleFont: .subtitle02,
                messageFont: .body03,
                messageColor: Color(.inverseText01),
                buttonFont: .subtitle03,
                buttonTextColor: Color(.contrast01),
                buttonBorderColor: Color(.contrast01),
                closeButtonColor: Color(.inverseIcons01),
                backgroundColor: Color(.inverseBackground)
            )
        case .success:
            return .init(
                themeColor: Color(.inverseSuccess),
                icon: Image(.icnSuccess),
                titleFont: .subtitle02,
                messageFont: .body03,
                messageColor: Color(.inverseText01),
                buttonFont: .subtitle03,
                buttonTextColor: Color(.contrast01),
                buttonBorderColor: Color(.contrast01),
                closeButtonColor: Color(.inverseIcons01),
                backgroundColor: Color(.inverseBackground)
            )
        case .info:
            return .init(
                themeColor: Color(.inverseIcons01),
                icon: Image(.icnInfoCircle),
                titleFont: .subtitle02,
                messageFont: .body03,
                messageColor: Color(.inverseText01),
                buttonFont: .subtitle03,
                buttonTextColor: Color(.contrast01),
                buttonBorderColor: Color(.contrast01),
                closeButtonColor: Color(.inverseIcons01),
                backgroundColor: Color(.inverseBackground)
            )
        case .custom(let config):
            return config
        }
    }
}

public struct NotificationStyleConfiguration: Equatable {
    var themeColor: Color
    var icon: Image
    var titleFont: UIFont
    var messageFont: UIFont
    var messageColor: Color
    var buttonFont: UIFont
    var buttonTextColor: Color
    var buttonBorderColor: Color
    var closeButtonColor: Color
    var backgroundColor: Color
    
    public init(
        themeColor: Color? = nil,
        icon: Image? = nil,
        titleFont: UIFont = .subtitle02,
        messageFont: UIFont = .body03,
        messageColor: Color? = nil,
        buttonFont: UIFont = .subtitle03,
        buttonTextColor: Color? = nil,
        buttonBorderColor: Color? = nil,
        closeButtonColor: Color? = nil,
        backgroundColor: Color? = nil
    ) {
        self.themeColor = themeColor ?? Color(.inverseIcons01)
        self.icon = icon ?? Image(.icnInfoCircle)
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.messageColor = messageColor ?? Color(.inverseText01)
        self.buttonFont = buttonFont
        self.buttonTextColor = buttonTextColor ?? Color(.contrast01)
        self.buttonBorderColor = buttonBorderColor ?? Color(.contrast01)
        self.closeButtonColor = closeButtonColor ?? Color(.inverseIcons01)
        self.backgroundColor = backgroundColor ?? Color(.inverseBackground)
    }
}
