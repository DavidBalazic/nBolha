//
//  NCTextFieldConfiguration.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

public struct NCTextFieldConfiguration: Configurable {
    public var font: UIFont
    public var textColor: UIColor?
    public var textAlignment: NSTextAlignment
    public var isSecureTextEntry: Bool
    public var keyboardType: UIKeyboardType
    public var capitalizationType: UITextAutocapitalizationType
    public var autocorrectionType: UITextAutocorrectionType
    public var returnKeyType: UIReturnKeyType
    
    public init(font: UIFont = .body02,
                textColor: UIColor? = .text02,
                textAlignment: NSTextAlignment = .left,
                isSecureTextEntry: Bool = false,
                keyboardType: UIKeyboardType = .default,
                capitalizationType: UITextAutocapitalizationType = .none,
                autocorrectionType: UITextAutocorrectionType = .no,
                returnKeyType: UIReturnKeyType = .default) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.isSecureTextEntry = isSecureTextEntry
        self.keyboardType = keyboardType
        self.capitalizationType = capitalizationType
        self.autocorrectionType = autocorrectionType
        self.returnKeyType = returnKeyType
    }
    
    public func withSecureTextEntry(_ isSecureTextEntry: Bool) -> NCTextFieldConfiguration {
        var copy = self
        copy.isSecureTextEntry = isSecureTextEntry
        return copy
    }
}
