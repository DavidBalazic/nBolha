//
//  AppLaunchCoordinator.swift
//  ComplexChinaApp
//
//  Created by Adel on 04/11/2023.
//

import UIKit
import SwiftUI
import nBolhaNetworking

final class AppLaunchCoordinator: NSObject {
    private var navigationController: UINavigationController?
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
        setupNotificationObserver()
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTokenExpired),
            name: .tokenExpiredNotification,
            object: nil
        )
    }
    
    @objc private func handleTokenExpired() {
        DispatchQueue.main.async {
            self.launchLoginCoordinator()
        }
    }

    func start() {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        if KeyChainManager(service: Constants.keychainServiceIdentifier).get(forKey: "sessionTokenID") != nil {
            TabBarCoordinator(
                navigationController: navigationController
            ).start()
        } else {
            launchLoginCoordinator()
        }
    }
    
    private func launchLoginCoordinator() {
        LoginCoordinator(navigationController: navigationController).start()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: .tokenExpiredNotification,
            object: nil
        )
    }
}
