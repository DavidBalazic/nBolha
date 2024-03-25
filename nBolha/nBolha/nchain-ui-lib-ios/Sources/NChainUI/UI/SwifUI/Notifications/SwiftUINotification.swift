//
//  SwiftUINotification.swift
//
//
//  Created by Miha Šemrl on 23. 02. 24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SwiftUINotification: View {
    private let type: NotificationStyle
    private let title: String
    private let message: String?
    private let showCloseButton: Bool
    private let buttonTitle: String?
    private let buttonTapped: Action?
    private let dismissAction: Action
    
    public init(
        type: NotificationStyle,
        title: String,
        message: String?,
        showCloseButton: Bool = true,
        buttonTitle: String? = nil,
        buttonTapped: Action? = nil,
        dismissAction: @escaping Action
    ) {
        self.type = type
        self.title = title
        self.message = message
        self.showCloseButton = showCloseButton
        self.buttonTitle = buttonTitle
        self.buttonTapped = buttonTapped
        self.dismissAction = dismissAction
    }
    
    public var body: some View {
        HStack (alignment: .top, spacing: NCConstants.Margins.small.rawValue) {
            type.config.icon
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: NCConstants.IconSize.huge.rawValue,
                    height: NCConstants.IconSize.huge.rawValue
                )
                .foregroundColor(type.config.themeColor)
            VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
                Text(title)
                    .font(Font(type.config.titleFont))
                    .foregroundStyle(type.config.themeColor)
                if let message {
                    Text(message)
                        .font(Font(type.config.messageFont))
                        .foregroundStyle(type.config.messageColor)
                }
                if let buttonTitle {
                    Spacer()
                        .frame(height: NCConstants.Margins.small.rawValue)
                    Button(action: {
                        buttonTapped?()
                        dismissAction()
                    }, label: {
                        Text(buttonTitle)
                            .font(Font(type.config.buttonFont))
                    })
                    .padding(.vertical, NCConstants.Margins.small.rawValue)
                    .padding(.horizontal, NCConstants.Margins.large.rawValue)
                    .foregroundColor(type.config.buttonTextColor)
                    .background(
                        RoundedRectangle(
                            cornerRadius: NCConstants.Radius.small.rawValue,
                            style: .continuous
                        )
                        .stroke(type.config.buttonBorderColor, lineWidth: 1)
                    )
                }
            }
            Spacer()
            showCloseButton ? Button {
                dismissAction()
            } label: {
                Image(.icnClose)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: NCConstants.IconSize.huge.rawValue,
                        height: NCConstants.IconSize.huge.rawValue
                    )
                    .foregroundColor(type.config.closeButtonColor)
            } : nil
        }
        .padding(NCConstants.Margins.large.rawValue)
        .background {
            RoundedRectangle(cornerRadius: NCConstants.Radius.small.rawValue)
                .fill(type.config.backgroundColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, NCConstants.Margins.medium.rawValue)
    }
}

// MARK: - ViewModel

public enum NotificationSide {
    case top
    case bottom
}

public struct SwiftUINotificationModel: Equatable {
    var type: NotificationStyle
    var title: String
    var message: String?
    var showCloseButton: Bool
    var buttonTitle: String?
    var buttonTapped: Action?
    var duration: Double = 3
    var side: NotificationSide = .top
    
    public init(
        type: NotificationStyle,
        title: String,
        message: String? = nil,
        showCloseButton: Bool = true,
        buttonTitle: String? = nil,
        buttonTapped: Action? = nil,
        duration: Double = 3, //If set to 0 it will not remove automatically
        side: NotificationSide = .top
    ) {
        self.type = type
        self.title = title
        self.message = message
        self.showCloseButton = showCloseButton
        self.buttonTitle = buttonTitle
        self.buttonTapped = buttonTapped
        self.duration = duration
        self.side = side
    }
    
    public static func == (lhs: SwiftUINotificationModel, rhs: SwiftUINotificationModel) -> Bool {
        return lhs.type == rhs.type &&
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.showCloseButton == rhs.showCloseButton &&
        lhs.buttonTitle == rhs.buttonTitle &&
        lhs.duration == rhs.duration &&
        lhs.side == rhs.side
    }
}

// MARK: - ViewModifier

@available(iOS 15.0, *)
public struct SwiftUINotificationModifier: ViewModifier {
    @Binding var notificationModel: SwiftUINotificationModel?
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainNotificationView()
                        .offset(y: notificationModel?.side == .bottom ? -30 : 0)
                }.animation(.spring(), value: notificationModel)
            )
            .onChange(of: notificationModel) { value in
                showNotification()
            }
    }
    
    @ViewBuilder func mainNotificationView() -> some View {
        if let notificationModel {
            VStack {
                notificationModel.side == .bottom ? Spacer() : nil
                SwiftUINotification(
                    type: notificationModel.type,
                    title: notificationModel.title,
                    message: notificationModel.message,
                    showCloseButton: notificationModel.showCloseButton,
                    buttonTitle: notificationModel.buttonTitle,
                    buttonTapped: notificationModel.buttonTapped) {
                        dismissNotification()
                    }
                notificationModel.side == .bottom ? nil : Spacer()
            }
            .transition(.move(edge: notificationModel.side == .bottom ? .bottom : .top))
            .frame(maxWidth: .infinity)
        }
    }
    
    private func showNotification() {
        guard let notificationModel else { return }
        
        if notificationModel.duration > 0 {
            
            let task = DispatchWorkItem {
                dismissNotification()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + notificationModel.duration, execute: task)
        }
    }
    
    private func dismissNotification() {
        withAnimation {
            notificationModel = nil
        }
    }
}

@available(iOS 15.0, *)
extension View {
    public func notification(notificationModel: Binding<SwiftUINotificationModel?>) -> some View {
        self.modifier(SwiftUINotificationModifier(notificationModel: notificationModel))
    }
}
