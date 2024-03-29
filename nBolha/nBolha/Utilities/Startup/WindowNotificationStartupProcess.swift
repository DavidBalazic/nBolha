//
//  WindowNotificationStartupProcess.swift
//  nBolha
//
//  Created by David Balažic on 29. 3. 24.
//

import Foundation
import UIKit
import nBolhaUI
import nBolhaCore

struct WindowNotificationsStartupProcess: StartupProcess {
    let window: UIWindow

    func run() {
        WindowNotificationInstallation.instance.install(
            in: window
        )
    }
}
