//
//  HomeCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator, HomeNavigationDelegate {
    private weak var navigationController: UINavigationController?
    
    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        let view = TabBarView(viewModel: .init(navigationDelegate: self))
        navigationController?.setViewControllers(
            [view.asViewController],
            animated: false
        )
        
        navigationController?.isNavigationBarHidden = true
        
        return navigationController ?? UIViewController()
    }
    
    // MARK: - HomeNavigationDelegate
    
    func showCategoriesScreen() {
        //TODO: implement
    }
}
