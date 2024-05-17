//
//  HomeCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import Foundation
import UIKit
import Combine
import nBolhaUI
import nBolhaNetworking

final class HomeCoordinator: NSObject, Coordinator, HomeNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    private var switchTab: (() -> Void)?
    
    init(
        navigationController: UINavigationController? = nil,
        switchTab: (() -> Void)?
    ) {
        self.navigationController = navigationController
        self.switchTab = switchTab
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = HomeViewModel(
            navigationDelegate: self
        )
        let view = HomeView(viewModel: viewModel)
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
    
        navController.pushViewController(view.asViewController, animated: true)
        return navController
    }
    
    // MARK: - HomeNavigationDelegate
    
    func showCategoriesScreen() {
        switchTab?()
        CategoriesCoordinator().start()
    }
    
    func showDetailScreen(advertisementId: Int) {
        DetailCoordinator(
            navigationController: navigationController, 
            advertisementId: advertisementId
        ).start()
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let imageView = UIImageView(image: UIImage(resource: .logo))
        imageView.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 223, height: 21))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        viewController.navigationItem.titleView = titleView
        
        let backButtonImage = UIImage(resource: .backButton)
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}
