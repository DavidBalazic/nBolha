//
//  WindowNotificationInstallation.swift
//  nBolhaUI
//
//  Created by David Balažic on 28. 3. 24.
//

import UIKit
import SwiftUI
import SnapKit
import nBolhaCore
import NChainUI

//public final class WindowNotificationInstallation {
//    public static let instance = WindowNotificationInstallation()
//
//    @MainActor
//    public private(set) weak var activeViewModel: WindowNotificationViewModel?
//    private weak var window: UIWindow?
//
//    private init() { }
//
//    public func install(in window: UIWindow) {
//        self.window = window
//    }
//
//    @MainActor
//    public func dismissActive() {
//        activeViewModel?.dismissNotification()
//        activeViewModel = nil
//    }
//
//    @MainActor
//    @discardableResult
//    public func present(
//        notification: NotificationView.Notification
//    ) -> WindowNotificationViewModel? {
//        dismissActive()
//
//        guard let parentView = window else { return nil }
//
//        let viewModel = WindowNotificationViewModel(notification: notification)
//        let notificationView = WindowNotificationsView(viewModel: viewModel)
//        let viewController = UIHostingController(rootView: notificationView)
//
//        guard let view = viewController.view else {
//            fatalError("WindowNotificationInstallation unable to retrieve view controller view")
//        }
//
//        viewModel.onDismiss = { [weak view] in
//            view?.removeFromSuperview()
//        }
//
//        view.backgroundColor = .clear
//        view.isOpaque = false
//        parentView.addSubview(view)
//        
//        view.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview().inset(NCConstants.Margins.giant.rawValue)
//            make.top.equalTo(parentView.safeAreaLayoutGuide.snp.top)
//        }
//        
//        view.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview().inset(NCConstants.Margins.giant.rawValue)
//            $0.top.equalTo(parentView.safeAreaLayoutGuide.snp.top)
//        }
//
//        activeViewModel = viewModel
//        return viewModel
//    }
//}

//MARK: Brez SnapKita

public final class WindowNotificationInstallation {
    public static let instance = WindowNotificationInstallation()

    @MainActor
    public private(set) weak var activeViewModel: WindowNotificationViewModel?
    private weak var window: UIWindow?

    private init() { }

    public func install(in window: UIWindow) {
        self.window = window
    }

    @MainActor
    public func dismissActive() {
        activeViewModel?.dismissNotification()
        activeViewModel = nil
    }

    @MainActor
    @discardableResult
    public func present(
        notification: NotificationView.Notification
    ) -> WindowNotificationViewModel? {
        dismissActive()

        guard let parentView = window else { return nil }

        let viewModel = WindowNotificationViewModel(notification: notification)
        let notificationView = WindowNotificationsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: notificationView)

        guard let view = viewController.view else {
            fatalError("WindowNotificationInstallation unable to retrieve view controller view")
        }

        viewModel.onDismiss = { [weak view] in
            view?.removeFromSuperview()
        }

        view.backgroundColor = .clear
        view.isOpaque = false
        parentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor)
        ])

        activeViewModel = viewModel
        return viewModel
    }
}
