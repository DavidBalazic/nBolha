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

final class CategoriesCoordinator: NSObject, Coordinator, CategoriesNavigationDelegate, FilterNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    
    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = CategoriesViewModel(
            navigationDelegate: self
        )
        let view = CategoriesView(viewModel: viewModel)
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        return navController
    }
    
    // MARK: - CategoriesNavigationDelegate
    
    func showCategoriesDetailScreen() {
        let viewModel = CategoriesViewModel(
            navigationDelegate: self
        )
        let filterViewModel = FilterViewModel(
            navigationDelegate: self
        )
        let view = CategoriesDetailView(viewModel: viewModel, filterViewModel: filterViewModel)
        
        navigationController?.pushViewController(
            view.asViewController,
            animated: true
        )
    }
    
    func showCategoriesScreen() {
        //TODO: implement
    }
    
    func showFilterScreen() {
        //TODO: implement
    }
    
    func showDetailScreen(selectedAdvertisement: Advertisement) {
        DetailCoordinator(
            navigationController: navigationController, advertisement: selectedAdvertisement
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
