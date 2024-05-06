//
//  AdvertisementDetailCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 19. 4. 24.
//

import Foundation
import UIKit
import nBolhaUI
import nBolhaNetworking

final class DetailCoordinator: NSObject, Coordinator, DetailNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    private var advertisement: Advertisement
    
    init(
        navigationController: UINavigationController? = nil,
        advertisement: Advertisement
    ) {
        self.navigationController = navigationController
        self.advertisement = advertisement
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = DetailViewModel(
            navigationDelegate: self, advertisement: advertisement
        )
        let view = DetailView(viewModel: viewModel)
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        
        return navController
    }
    
    // MARK: - DetailNavigationDelegate
    
    func disableNavigations() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = false
    }
    
    func enableNavigations() {
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       //TODO: implement
    }
}
