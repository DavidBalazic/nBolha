//
//  CategoriesCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import Foundation
import UIKit

final class CategoriesCoordinator: NSObject, Coordinator, CategoriesNavigationDelegate, UINavigationControllerDelegate {
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
        
    func showCategoriesDetailView() {
        //TODO: implement
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let imageView = UIImageView(image: UIImage(resource: .logo))
        imageView.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 223, height: 21))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        viewController.navigationItem.titleView = titleView
    }
}
