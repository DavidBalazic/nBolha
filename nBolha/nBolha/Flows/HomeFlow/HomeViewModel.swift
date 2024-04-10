//
//  HomeViewModel.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import Foundation
import nBolhaNetworking

protocol HomeNavigationDelegate: AnyObject {
    func showCategoriesScreen()
}

final class HomeViewModel: ObservableObject {
    private let navigationDelegate: HomeNavigationDelegate?
    @Published var isLoading = false
    @Published var advertisements: [Advertisement] = []
    
    init(
        navigationDelegate: HomeNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
        Task {
            await LoadAdvertisements()
        }
    }
    
    private func LoadAdvertisements() async{
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let advertisementWorker = AdvertisementWorker()
        advertisementWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.advertisements = response ?? []
            }
        }
    }
    
    func startExploringTapped() {
        navigationDelegate?.showCategoriesScreen()
    }
}
