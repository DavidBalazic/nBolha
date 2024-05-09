//
//  LoginViewModel.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import Foundation
import Combine
import nBolhaCore
import nBolhaUI
import nBolhaNetworking
import UIKit

protocol LoginNavigationDelegate: AnyObject {
    func showHomeScreen()
    func showNoConnectionScreen()
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
    private let notificationService: WindowNotificationService
    private let keychaninManager = KeyChainManager(service: Constants.keychainServiceIdentifier)
    
    init(
        navigationDelegate: LoginNavigationDelegate?,
        notificationService: WindowNotificationService = DefaultWindowNotificationService()
    ) {
        self.navigationDelegate = navigationDelegate
        self.notificationService = notificationService
        initializeObserving()
    }
    
    @MainActor
    func loginTapped() async {
        validateFields()
        guard !email.isEmpty, !password.isEmpty else { return }
        await login()
    }
    
    func termsTapped() {
        navigationDelegate?.showTermsScreen()
    }
    
    func privacyTapped() {
        navigationDelegate?.showPrivacyScreen()
    }
    
    func validateFields() {
        errorEmailText = email.isEmpty ? "Please fill in your email" : nil
        errorPasswordText = password.isEmpty ? "Please fill in your password" : nil
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
    }
    
    @MainActor
    private func login() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let loginWorker = LoginWorker(username: email, password: password)
        loginWorker.execute { (response, error) in
            if let response = response {
                let token = response.token
                let email = response.username
                let sessionTokenId = "sessionTokenID"
                let userEmail = "userEmail"
                self.keychaninManager.set(token, forKey: sessionTokenId)
                self.keychaninManager.set(email, forKey: userEmail)
                self.navigationDelegate?.showHomeScreen()
            } else if error is NetworkingBadRequestError {
                self.notificationService.notify.send(NotificationView.Notification.LoginFailed)
            } else if response == nil, error == nil {
                //TODO: handle no internet connection
                self.navigationDelegate?.showNoConnectionScreen()
            } else {
                self.notificationService.notify.send(NotificationView.Notification.Other)
            }
        }
    }
 }
