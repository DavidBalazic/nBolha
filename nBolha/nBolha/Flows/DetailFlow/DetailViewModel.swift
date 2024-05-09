//
//  DetailViewModel.swift
//  nBolha
//
//  Created by David Balažic on 19. 4. 24.
//

import Foundation
import nBolhaNetworking
import MessageUI

protocol DetailNavigationDelegate: AnyObject {
    func disableNavigations()
    func enableNavigations()
    func showMailApp()
}

final class DetailViewModel: ObservableObject{
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
    
    func contactSellerTapped() {
        navigationDelegate?.showMailApp()
    }
}
