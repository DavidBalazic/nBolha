//
//  AdvertisementDetailCoordinator.swift
//  nBolha
//
//  Created by David Balažic on 19. 4. 24.
//

import Foundation
import UIKit
import nBolhaUI
import nBolhaNetworking
import MessageUI

final class DetailCoordinator: NSObject, Coordinator, DetailNavigationDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    private weak var navigationController: UINavigationController?
    private var advertisement: Advertisement
    
    init(
        navigationController: UINavigationController? = nil,
        advertisement: Advertisement
    ) {
        self.navigationController = navigationController
        self.advertisement = advertisement
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewModel = DetailViewModel(
            navigationDelegate: self, advertisement: advertisement
        )
        let view = DetailView(viewModel: viewModel)
        
        let navController = navigationController ?? UINavigationController()
        navigationController = navController
        navigationController?.delegate = self
        
        navController.pushViewController(view.asViewController, animated: true)
        
        return navController
    }
    
    // MARK: - DetailNavigationDelegate
    
    func disableNavigations() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = false
    }
    
    func enableNavigations() {
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    func showMailApp() {
        let keychainManager = KeyChainManager(service: Constants.keychainServiceIdentifier)
        if let recipientEmail = keychainManager.get(forKey: "userEmail") {
            let subject = ""
            let body = ""
            
            // Show default mail composer
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([recipientEmail])
                mail.setSubject(subject)
                mail.setMessageBody(body, isHTML: false)
                
                navigationController?.present(mail, animated: true)
                
            } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                UIApplication.shared.open(emailUrl)
            }
        }
    }
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       //TODO: implement
    }
}
