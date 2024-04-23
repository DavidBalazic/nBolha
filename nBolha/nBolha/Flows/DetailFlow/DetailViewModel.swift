//
//  DetailViewModel.swift
//  nBolha
//
//  Created by David Balažic on 19. 4. 24.
//

import Foundation
import nBolhaNetworking

protocol DetailNavigationDelegate: AnyObject {
    func disableNavigations()
    func enableNavigations()
}

final class DetailViewModel: ObservableObject {
    private let navigationDelegate: DetailNavigationDelegate?
    @Published var advertisement: Advertisement
    
    init(
        navigationDelegate: DetailNavigationDelegate?,
        advertisement: Advertisement
    ) {
        self.navigationDelegate = navigationDelegate
        self.advertisement = advertisement
    }
    
    func disableNavigations() {
        navigationDelegate?.disableNavigations()
    }
    
    func enableNavigations() {
        navigationDelegate?.enableNavigations()
    }
}
