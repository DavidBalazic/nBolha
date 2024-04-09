//
//  NotificationView.swift
//  nBolhaUI
//
//  Created by David Balažic on 28. 3. 24.
//

import SwiftUI
import NChainUI

public struct NotificationView: View {
    public struct Notification: Equatable {
        public let type: `Type`
        public let errorMessage: String
        public let errorDescription: String
        
        public static var LoginFailed: Notification {
            return Notification(
                type: .warning,
                errorMessage: "Login failed",
                errorDescription: "Incorrect email or password was entered. Please verify them and try again."
            )
        }
      
        public static var Other: Notification {
            return Notification(
                type: .warning,
                errorMessage: "Something went wrong",
                errorDescription: "Please try again later."
            )
        }

        public init(
            type: `Type`,
            errorMessage: String,
            errorDescription: String
        ) {
            self.type = type
            self.errorMessage = errorMessage
            self.errorDescription = errorDescription
        }

        public enum `Type`: Equatable {
            case warning

            var titleImage: Image {
                return Image(uiImage: .icnAlert ?? UIImage())
            }

            var color: Color {
                return Color(.inverseError!)
            }
        }
    }
    var notification: Notification
    public var dismissAction: () -> Void
    
    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
                HStack {
                    notification.type.titleImage
                        .foregroundColor(Color(notification.type.color))
                    Text(notification.errorMessage)
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(notification.type.color))
                    Spacer()
                    Button(action: dismissAction) {
                        Image(uiImage: .icnClose ?? UIImage())
                            .foregroundColor(Color(.inverseIcons01!))
                    }
                }
                Text(notification.errorDescription)
                    .textStyle(.body03)
                    .foregroundStyle(Color(.inverseText01!))
                    .padding(.leading, NCConstants.Margins.huge.rawValue)
                    .padding(.trailing, 10)
                }
                .padding(NCConstants.Margins.large.rawValue)
            }
            .background(Color(.inverseBackground!))
            .cornerRadius(NCConstants.Margins.small.rawValue, corners: .allCorners)
            .padding(NCConstants.Margins.large.rawValue)

    }
}

//#Preview {
//    NotificationView()
//}
