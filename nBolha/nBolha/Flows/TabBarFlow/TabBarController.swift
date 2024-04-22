//
//  TabBarController.swift
//  nBolha
//
//  Created by David Balažic on 15. 4. 24.
//

import Foundation
import UIKit
import Combine

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    //MARK: - Properties
    private var bag = Set<AnyCancellable>()
    private let viewModel: TabBarViewModel
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandPrimary
        return view
    }()
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.addSubview(indicatorView)
        
        viewControllers = viewModel.tabs.map {
            viewModel.viewController(for: $0)
        }
        initializeObserving()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        moveIndicator(to: selectedIndex)
        updateSelectedTab()
    }
    
    //MARK: - Methods
    
    private func initializeObserving() {
        viewModel.showTab
            .map({ $0.tabBarIndex })
            .sink { [weak self] index in
                self?.selectedIndex = index
            }
            .store(in: &bag)
    }
    
    private func moveIndicator(
        to index: Int
    ) {
        let indicatorSize = CGSize(width: 4, height: 2)
        let indicatorYOffset: CGFloat = 3
        let wholeItemWidth: Double = tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1)
        let xPosition = (CGFloat(index) * wholeItemWidth) + (wholeItemWidth / 2) - (indicatorSize.width / 2)
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1.0
        ) { [self] in
            indicatorView.frame = CGRect(
                x: xPosition,
                y: indicatorYOffset,
                width: indicatorSize.width,
                height: indicatorSize.height
            )
            indicatorView.backgroundColor = .brandSecondary!
        }
    }
    
    private func updateSelectedTab() {
        guard let selectedViewController = selectedViewController,
              let selectedTabIndex = viewControllers?.firstIndex(of: selectedViewController)
        else {
            return
        }
        
        viewControllers?.enumerated().forEach { index, viewController in
            let isSelected = index == selectedTabIndex
            let tabBarItem = viewController.tabBarItem
            let image = isSelected ? tabBarItem?.selectedImage : tabBarItem?.image
            
            if let originalImage = image?.withRenderingMode(.alwaysOriginal) {
                let tintedImage = originalImage.withTintColor(isSelected ? .brandSecondary! : .gray)
                tabBarItem?.selectedImage = tintedImage
                tabBarItem?.image = tintedImage
            }
        }
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        moveIndicator(to: viewControllers?.firstIndex(of: viewController) ?? 0)
        updateSelectedTab()
    }
}
