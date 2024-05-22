//
//  ProfileCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 17. 5. 24.
//

import Foundation
import UIKit
import NChainUI
import nBolhaNetworking

final class ProfileCoordinator: NSObject, Coordinator, ProfileNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    private var viewModel: ProfileViewModel
    
    init(
        navigationController: UINavigationController? = nil,
        viewModel: ProfileViewModel
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    @discardableResult
    func start() -> UIViewController {
        viewModel = ProfileViewModel(
            navigationDelegate: self
        )
        let view = ProfileView(
            viewModel: viewModel
        )
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        return navController
    }
    
    // MARK: - ProfileNavigationDelegate
    
    func showDetailScreen(advertisementId: Int) {
        DetailCoordinator(
            navigationController: navigationController,
            advertisementId: advertisementId
        ).start()
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let signOutAction = UIAction(title: "Sign Out", image: .signOut) { _ in
            self.viewModel.signOutTapped()
        }
        let signOutMenu = UIMenu(title: "", children: [signOutAction])
        
        let ellipsisButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: nil)
        ellipsisButton.tintColor = UIColor.icons03
        ellipsisButton.menu = signOutMenu
        
        viewController.navigationItem.rightBarButtonItem = ellipsisButton
    }
}
