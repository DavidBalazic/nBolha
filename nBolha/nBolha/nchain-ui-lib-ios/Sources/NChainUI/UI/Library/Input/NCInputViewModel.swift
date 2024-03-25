//
//  NCInputViewModel.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

public struct NCInputViewModel: NCInputViewModelable {
    public var title: String?
    public var value: String?
    public var placeholder: String?
    public var hint: String?
    public var error: String?
    public var info: NCImageViewModel?
    public var leading: NCImageViewModel?
    public var trailing: NCImageViewModel?
    
    public init(title: String? = nil,
                value: String? = nil,
                placeholder: String? = nil,
                hint: String? = nil,
                error: String? = nil,
                leading: NCImageViewModel? = nil,
                trailing: NCImageViewModel? = nil) {
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.hint = hint
        self.error = error
        self.leading = leading
        self.trailing = trailing
    }
}
