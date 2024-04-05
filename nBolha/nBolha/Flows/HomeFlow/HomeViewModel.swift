//
//  HomeViewModel.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import Foundation

protocol HomeNavigationDelegate: AnyObject {
    
}

final class HomeViewModel: ObservableObject {
    private let navigationDelegate: HomeNavigationDelegate?
    
    init(
        navigationDelegate: HomeNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
}
