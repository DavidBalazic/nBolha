//
//  ProfileCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 17. 5. 24.
//

import Foundation
import UIKit
import NChainUI

final class ProfileCoordinator: NSObject, Coordinator, ProfileNavigationDelegate, UINavigationControllerDelegate {
    private weak var navigationController: UINavigationController?
    
    init(
        navigationController: UINavigationController? = nil
    ) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = ProfileViewModel(
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
        let signOutMenu = UIMenu(title: "", children: [signOutAction])
        
        let ellipsisButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: nil)
        ellipsisButton.tintColor = UIColor.icons03
        ellipsisButton.menu = signOutMenu
        
        viewController.navigationItem.rightBarButtonItem = ellipsisButton
    }
    
    let signOutAction = UIAction(title: "Sign out", image: .signOut) { _ in
        //TODO: implement
        print("Sign Out tapped")
    }
}
