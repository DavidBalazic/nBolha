//
//  AppDelegate.swift
//  Demo
//
//  Created by Rok Črešnik on 10/08/2023.
//

import UIKit
import NChainUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIFont.registerFont(UIFont.FontNameItalic)
        UIFont.registerFont(UIFont.FontNameMedium)
        UIFont.registerFont(UIFont.FontNameMediumItalic)
        UIFont.registerFont(UIFont.FontNameRegular)
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

