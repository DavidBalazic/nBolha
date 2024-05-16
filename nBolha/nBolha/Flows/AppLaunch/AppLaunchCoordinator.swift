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
    }

    func start() {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
//        if let token = KeyChainManager(service: Constants.keychainServiceIdentifier).get(forKey: "sessionTokenID") {
//            TabBarCoordinator(
//                navigationController: navigationController
//            ).start()
//        } else {
//            LoginCoordinator(
//                navigationController: navigationController
//            ).start()
//        }
        LoginCoordinator(
            navigationController: navigationController
        ).start()
    }
}
