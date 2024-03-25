//
//  TestViewModel.swift
//  ComplexChinaApp
//
//  Created by Luka Pernousek on 17. 11. 23.
//

import Foundation

protocol TestNavigationDelegate: AnyObject {
    func showTestDetailsScreen()
    func showTestInfoScreen(info: String)
}

final class TestViewModel: ObservableObject {
    private let navigationDelegate: TestNavigationDelegate?
    @Published var nameText = ""
    @Published var errorText: String?

    init(navigationDelegate: TestNavigationDelegate?) {
        self.navigationDelegate = navigationDelegate
    }

    func showTestDetailsTapped() {
        navigationDelegate?.showTestDetailsScreen()
    }
    
    func showTestInfoScreenTapped() {
        navigationDelegate?.showTestInfoScreen(info: "Hey, this is a test.")
    }
}
