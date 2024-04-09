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
        HomeCoordinator(
            navigationController: navigationController
        ).start()
    }
    
    func showTermsScreen() {
        let webView = WebView(
            url: DocumentURL.terms.url
        )
        navigationController?.pushViewController(
            webView.asViewController,
            animated: true
        )
    }
    
    func showPrivacyScreen() {
        let webView = WebView(
            url: DocumentURL.privacyPolicy.url
        )
      
        navigationController?.pushViewController(
            webView.asViewController,
            animated: true
        )
    }
    
    func showNoConnectionScreen() {
        let view = NoConnectionView()
        
        navigationController?.pushViewController(
            view.asViewController,
            animated: true
        )
    }
    
}
