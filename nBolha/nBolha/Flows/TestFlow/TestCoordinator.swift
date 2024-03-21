//
//  TestCoordinator.swift
//  nBolha
//
//  Created by Adel Burekovic on 20. 03. 24.
//

import UIKit
import nBolhaUI

final class TestCoordinator: Coordinator, TestNavigationDelegate {
    private weak var navigationController: UINavigationController?

    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }

    @discardableResult
    func start() -> UIViewController {
        let view = TestView(viewModel: .init(navigationDelegate: self))
//        navigationController?.setViewControllers([view.asViewController], animated: false)
        return navigationController ?? UIViewController()
    }
    
    // MARK: - TestNavigationDelegate
    
    func showTestDetailsScreen() {
        //
    }
    
    func showTestInfoScreen(info: String) {
        //
    }
}
