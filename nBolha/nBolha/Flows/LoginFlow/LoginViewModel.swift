//
//  LoginViewModel.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import Foundation

protocol LoginNavigationDelegate: AnyObject {
    func showHomeScreen()
    //func showNoConnectionScreen()
}

final class LoginViewModel: ObservableObject {
    private let navigationDelegate: LoginNavigationDelegate?
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(navigationDelegate: LoginNavigationDelegate?) {
        self.navigationDelegate = navigationDelegate
    }

    func loginButtonTapped() {
        navigationDelegate?.showHomeScreen()
    }
}
