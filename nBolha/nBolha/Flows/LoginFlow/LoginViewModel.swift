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
    private let notificationService: WindowNotificationService
    private let errorSubject = PassthroughSubject<Error, Never>()
    private var bag = Set<AnyCancellable>()
    
    init(
        navigationDelegate: LoginNavigationDelegate?,
        notificationService: WindowNotificationService = DefaultWindowNotificationService()
    ) {
        self.navigationDelegate = navigationDelegate
        self.notificationService = notificationService
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
        notificationService.notify.send(NotificationView.Notification(type: .warning, errorMessage: "Login failed", errorDescription: "Incorrect email and password combination was entered. Please verify them and try again."))
//        notificationService.notify.send(NotificationView.Notification(type: .warning, errorMessage: "Something went wrong", errorDescription: "Please try again later."))
        navigationDelegate?.showHomeScreen()
    }
 }
