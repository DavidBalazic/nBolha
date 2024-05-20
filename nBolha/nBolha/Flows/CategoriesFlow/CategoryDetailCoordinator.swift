//
//  CategoriesCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import Foundation
import UIKit
import nBolhaUI
import nBolhaNetworking

final class CategoryDetailCoordinator: NSObject, Coordinator, CategoryDetailNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    private var category: String
    
    init(
        navigationController: UINavigationController? = nil,
        category: String
    ) {
        self.navigationController = navigationController
        self.category = category
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = CategoryDetailViewModel(
            navigationDelegate: self,
            category: category
        )
        let view = CategoryDetailView(viewModel: viewModel)
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        return navController
    }
    
    // MARK: - CategoriesNavigationDelegate
    
    func showCategoriesScreen() {
        navigationController?.popViewController(animated: true)
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
