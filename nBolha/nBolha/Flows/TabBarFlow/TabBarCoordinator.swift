//
//  TabBarCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 15. 4. 24.
//

import Foundation
import UIKit
import SwiftUI

final class TabBarCoordinator: Coordinator, TabBarNavigationDelegate {
    private weak var navigationController: UINavigationController?
    private var tabBarController: TabBarController?
    
    init(
        navigationController: UINavigationController?
    ) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start(animated: Bool) -> UIViewController {
        let viewModel = TabBarViewModel(
            navigationDelegate: self
        )
        let tabBarController = TabBarController(
            viewModel: viewModel
        )
        self.tabBarController = tabBarController
        navigationController?.isNavigationBarHidden = true
        navigationController?.setViewControllers([tabBarController], animated: animated)
        
        return tabBarController
    }
    
    @discardableResult
    func start() -> UIViewController {
        return start(animated: true)
    }
    
    func showCategories() {
        tabBarController?.selectedIndex = 1
    }
    
    func showProfile() {
        tabBarController?.selectedIndex = 4
        ProfileCoordinator(showSuccessMessage: true).start()
    }
}
