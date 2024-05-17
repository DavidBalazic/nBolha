//
//  UploadItemCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 9. 5. 24.
//

import Foundation
import UIKit
import NChainUI

final class UploadItemCoordinator: NSObject, Coordinator, UploadItemNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    
    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = UploadItemViewModel(
            navigationDelegate: self
        )
        let view = UploadItemView(
            viewModel: viewModel
        )
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        return navController
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.navigationBar.topItem?.title = "Add new item"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.brandTertiary!, NSAttributedString.Key.font: UIFont.subtitle02]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        
    }
}

