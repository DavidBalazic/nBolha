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
        let loginWorker = LoginWorker(username: email, password: password)
        do {
            guard let response = try await loginWorker.execute() else {
                return
            }
            let token = response.token
            let sessionTokenId = "sessionTokenID"
            self.keychaninManager.set(token, forKey: sessionTokenId)
            self.navigationDelegate?.showHomeScreen()
        } catch let error as NetworkingBadRequestError {
            self.notificationService.notify.send(NotificationView.Notification.LoginFailed)
        } catch {
            self.notificationService.notify.send(NotificationView.Notification.Other)
        }
    }
 }
