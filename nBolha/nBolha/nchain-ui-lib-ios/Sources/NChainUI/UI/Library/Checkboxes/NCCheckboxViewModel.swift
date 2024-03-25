//
//  NCCheckboxViewModel.swift
//  
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

public struct NCCheckboxViewModel: NCButtonViewModelable {
    public var title: String? = nil
    public var disabledTitle: String? = nil
    
    public init() {
        self.title = nil
        self.disabledTitle = nil
    }
}
