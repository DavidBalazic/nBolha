//
//  WindowNotificationViewModel.swift
//  nBolhaUI
//
//  Created by David Balažic on 28. 3. 24.
//

import Foundation
import SwiftUI
import Combine

public final class WindowNotificationViewModel: ObservableObject {
    var onDismiss: @MainActor () -> Void = { }
    @Published private(set) var isShown = false
    private var notificationDismissalTask: Task<Void, Error>?
    private var notificationDismissalTimerTask: Task<Void, Error>?

    let notification: NotificationView.Notification

    private let notificationDismissalInterval: TimeInterval = 5
    private let animationDuration: TimeInterval = 0.3

    init(notification: NotificationView.Notification) {
        self.notification = notification
    }

    @MainActor
    public func resetDismissTimer() {
        notificationDismissalTimerTask?.cancel()
        notificationDismissalTimerTask = Task.delayed(
            byTimeInterval: notificationDismissalInterval
        ) { [weak self] in
            await self?.dismissNotification()
        }
    }

    @MainActor
    func willAppear() {
        withAnimation(.easeOut(duration: animationDuration)) {
            isShown = true
        }
        resetDismissTimer()
    }

    @MainActor
    public func dismissNotification() {
        guard notificationDismissalTask == nil else {
            return
        }

        notificationDismissalTimerTask?.cancel()

        withAnimation(.easeIn(duration: animationDuration)) {
            isShown = false
        }

        // wait for animation to finish before calling onDismiss
        notificationDismissalTask = Task.delayed(
            byTimeInterval: animationDuration
        ) { [weak self] in
            await self?.onDismiss()
        }
    }
}
