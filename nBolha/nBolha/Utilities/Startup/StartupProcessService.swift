//
//  FontLoadStartupProcess.swift
//  ComplexChinaApp
//
//  Created by Luka Pernousek on 8. 11. 23.
//

import UIKit
import nBolhaCore

final class StartupProcessService {
    func execute(window: UIWindow) {
        WindowNotificationsStartupProcess(window: window).run()
        FontLoadStartupProcess().run()
    }
}
