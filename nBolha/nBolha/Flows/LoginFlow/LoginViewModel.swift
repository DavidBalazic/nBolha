//
//  LoginViewModel.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import Foundation

protocol LoginNavigationDelegate: AnyObject {
    func showHomeScreen()
    //TODO: implement show no screen
    //func showNoConnectionScreen()
    func showTermsScreen()
    func showPrivacyScreen()
}

final class LoginViewModel: ObservableObject {
    private let navigationDelegate: LoginNavigationDelegate?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorEmailText: String?
    @Published var errorPasswordText: String?
    
    init(navigationDelegate: LoginNavigationDelegate?) {
        self.navigationDelegate = navigationDelegate
    }

    func loginTapped() {
        navigationDelegate?.showHomeScreen()
    }
    
    func termsTapped() {
        navigationDelegate?.showTermsScreen()
    }
    
    func privacyTapped() {
        navigationDelegate?.showPrivacyScreen()
    }
}
