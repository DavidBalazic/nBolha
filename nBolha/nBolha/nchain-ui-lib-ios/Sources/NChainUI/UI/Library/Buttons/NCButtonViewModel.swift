//
//  NCButtonViewModel.swift
//  
//
//  Created by Miha Šemrl on 09/08/2023.
//

import UIKit

public struct NCButtonViewModel: NCButtonViewModelable {
    public var title: String?
    public var disabledTitle: String?
    
    public init(title: String? = nil, disabledTitle: String? = nil) {
        self.title = title
        self.disabledTitle = disabledTitle
    }
}
