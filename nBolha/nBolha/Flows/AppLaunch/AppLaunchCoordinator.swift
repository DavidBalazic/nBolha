//
//  AppLaunchCoordinator.swift
//  ComplexChinaApp
//
//  Created by Adel on 04/11/2023.
//

import UIKit
import SwiftUI

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
//        TestCoordinator(navigationController: navigationController)
//            .start()
        LoginCoordinator(navigationController: navigationController).start()
    }
}
