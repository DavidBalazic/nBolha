//
//  LoginViewModel.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import Foundation
import Combine
import nBolhaCore

protocol LoginNavigationDelegate: AnyObject {
    func showHomeScreen()
    //TODO: implement show no screen
    //func showNoConnectionScreen()
    func showTermsScreen()
    func showPrivacyScreen()
}

final class LoginViewModel: ObservableObject {
    private let navigationDelegate: LoginNavigationDelegate?
    @Published var isLoading = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorEmailText: String?
    @Published var errorPasswordText: String?
    @Published private(set) var isButtonEnabled = false
    
    init(
        navigationDelegate: LoginNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
        initializeObserving()
    }
    
    //@MainActor
    func loginTapped() {
        login()
    }
    
    func termsTapped() {
        navigationDelegate?.showTermsScreen()
    }
    
    func privacyTapped() {
        navigationDelegate?.showPrivacyScreen()
    }
    
    private func initializeObserving() {
        $email
            .dropFirst()
            .map { $0.isEmpty ? "Please fill in your email" : nil }
            .assign(to: &$errorEmailText)
           
        $password
            .dropFirst()
            .map { $0.isEmpty ? "Please fill in your password" : nil }
            .assign(to: &$errorPasswordText)
        
        $email.notEmptyPublisher
            .combineLatest( $password.notEmptyPublisher)
            .map { $0 && $1}
            .receive(on: DispatchQueue.main)
            .assign(to: &$isButtonEnabled)
    }
    
    //@MainActor
    private func login() {
        navigationDelegate?.showHomeScreen()

    }
 }
