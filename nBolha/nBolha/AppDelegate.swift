//
//  AppDelegate.swift
//  nBolha
//
//  Created by Adel Burekovic on 20. 03. 24.
//

import UIKit
import NChainUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: AppLaunchCoordinator?
    var nvc: UINavigationController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        StartupProcessService().execute(window: window)

        let coordinator = AppLaunchCoordinator(
            window: window
        )

        self.coordinator = coordinator
        coordinator.start()
        window.makeKeyAndVisible()
        return true
    }
}

