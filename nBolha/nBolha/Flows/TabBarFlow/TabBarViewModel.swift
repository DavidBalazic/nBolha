//
//  TabBarViewModel.swift
//  nBolha
//
//  Created by David Balažic on 15. 4. 24.
//

import Foundation
import Combine
import UIKit

protocol TabBarNavigationDelegate: AnyObject {
    func showCategories()
}

final class TabBarViewModel {
    let showTab = PassthroughSubject<TabBarTab.Item, Never>()
    
    private(set) lazy var tabs: [TabBarTab] = {
        [
            .init(item: .home),
            .init(item: .categories),
            .init(item: .wishlist)
        ]
    }()
    
    private let navigationDelegate: TabBarNavigationDelegate?
    
    init(
        navigationDelegate: TabBarNavigationDelegate? = nil
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    private func setup(_ viewController: UIViewController, for tab: TabBarTab) -> UIViewController {
        tab.bag.removeAll()
        
        tab.$selectedImage.sink { [weak viewController] in
            viewController?.tabBarItem.selectedImage = $0
        }.store(in: &tab.bag)
        
        tab.$image.sink { [weak viewController] in
            viewController?.tabBarItem.image = $0
        }.store(in: &tab.bag)
        
        return viewController
    }
    
    //MARK: - Public
    func viewController(for tab: TabBarTab) -> UIViewController {
        func setup(_ viewController: UIViewController) -> UIViewController {
            self.setup(viewController, for: tab)
        }
        
        switch tab.item {
        case .home:
            let coordinator = HomeCoordinator { [weak self] in
                self?.switchTab()
            }
            return setup(coordinator.start())
            
        case .categories:
            let coordinator = CategoriesCoordinator()
            return setup(coordinator.start())
            
        case .wishlist:
            let coordinator = WishlistCoordinator()
            return setup(coordinator.start())
        }
    }
    
    func switchTab() {
        navigationDelegate?.showCategories()
    }
}
