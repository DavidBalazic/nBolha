//
//  LoginCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import UIKit
import nBolhaUI
import nBolhaNetworking

final class LoginCoordinator: Coordinator, LoginNavigationDelegate {
    private weak var navigationController: UINavigationController?

    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }

    @discardableResult
    func start() -> UIViewController {
        let view = LoginView(viewModel: .init(navigationDelegate: self))
        navigationController?.setViewControllers(
            [view.asViewController],
            animated: false
        )
        // Hide the navigation bar
        navigationController?.isNavigationBarHidden = true
        
        return navigationController ?? UIViewController()
    }
    
    // MARK: - LoginNavigationDelegate
    
    func showHomeScreen() {
        TabBarCoordinator(
            navigationController: navigationController
        ).start()
    }
    
    func showTermsScreen() {
        
    }
    
    func showPrivacyScreen() {
        
    }
    
    func showNoConnectionScreen() {
        let view = NoConnectionView()
        
        navigationController?.pushViewController(
            view.asViewController,
            animated: true
        )
    }
}
