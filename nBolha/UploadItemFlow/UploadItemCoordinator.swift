//
//  UploadItemCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 9. 5. 24.
//

import Foundation
import UIKit

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
}

