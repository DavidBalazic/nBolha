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
        
        public static var PhotoUploadFailed: Notification {
            return Notification(
                type: .warning,
                errorMessage: "Photo upload failed",
                errorDescription: "Please try again."
            )
        }
        
        public static var PhotoUploadSuccess: Notification {
            return Notification(
                type: .success,
                errorMessage: "Upload complete",
                errorDescription: "Great news! Your item uploaded successfully."
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
            case success

            var titleImage: Image {
                switch self {
                case .warning:
                    return Image(uiImage: .icnAlert)
                case .success:
                    return Image(uiImage: .success)
                }
            }

            var color: Color {
                switch self {
                case .warning:
                    return Color(.inverseError!)
                case .success:
                    return Color(.inverseSuccess!)
                }
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
                        .foregroundColor(notification.type.color)
                    Text(notification.errorMessage)
                        .textStyle(.subtitle02)
                        .foregroundStyle(notification.type.color)
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
