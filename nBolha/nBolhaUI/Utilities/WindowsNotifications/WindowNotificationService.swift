//
//  WindowNotificationService.swift
//  nBolhaUI
//
//  Created by David Balažic on 28. 3. 24.
//

import UIKit
import SwiftUI
import Combine
import nBolhaCore

public protocol WindowNotificationService: AnyObject {
    var notify: PassthroughSubject<
        NotificationView.Notification,
        Never
    > {
        get
    }
}

final public class DefaultWindowNotificationService: WindowNotificationService {
    public let notify = PassthroughSubject<
        NotificationView.Notification,
        Never
    >()

    private var bag = Set<AnyCancellable>()

    public init() {
        initializeObserving()
    }

    // MARK: - Private

    private func initializeObserving() {
        notify.sink { [weak self] notification in
            guard let self else { return }
            Task {
                await self.presentIfDifferent(notification: notification)
            }
        }
        .store(in: &bag)
    }

    @MainActor
    private func presentIfDifferent(notification: NotificationView.Notification) {
        let windowNotifications = WindowNotificationInstallation.instance

        if let activeViewModel = windowNotifications.activeViewModel,
            activeViewModel.notification == notification {
            activeViewModel.resetDismissTimer()
        } else {
            windowNotifications.present(notification: notification)
        }
    }
}
