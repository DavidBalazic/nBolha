//
//  WishlistCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 6. 5. 24.
//

import Foundation
import UIKit

final class WishlistCoordinator: NSObject, Coordinator, WishlistNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    
    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = WishlistViewModel(
            navigationDelegate: self
        )
        let view = WishlistView(
            viewModel: viewModel
        )
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        return navController
    }
    
    // MARK: - WishlistNavigationDelegate
    
    func showDetailScreen(advertisementId: Int) {
        DetailCoordinator(
            navigationController: navigationController,
            advertisementId: advertisementId
        ).start()
    }
}
