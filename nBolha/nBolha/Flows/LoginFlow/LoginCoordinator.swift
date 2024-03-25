//
//  LoginCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import UIKit
import nBolhaUI

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
        return navigationController ?? UIViewController()
    }
    
    // MARK: - LoginNavigationDelegate
    
    func showHomeScreen() {
        // TODO: Push view controller to another screen
    }
    
}
