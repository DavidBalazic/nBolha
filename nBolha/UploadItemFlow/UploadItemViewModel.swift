//
//  UploadItemViewModel.swift
//  nBolha
//
//  Created by David Balažic on 9. 5. 24.
//

import Foundation

protocol UploadItemNavigationDelegate: AnyObject {
 
}

final class UploadItemViewModel: ObservableObject {
    private let navigationDelegate: UploadItemNavigationDelegate?
    
    init(
        navigationDelegate: UploadItemNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
}
