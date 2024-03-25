//
//  UITextField+Configurable.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

extension UITextField {
    public func configure(with config: NCTextFieldConfiguration) {
        font = config.font
        textColor = config.textColor
        textAlignment = config.textAlignment
        keyboardType = config.keyboardType
        isSecureTextEntry = config.isSecureTextEntry
        autocapitalizationType = config.capitalizationType
        autocorrectionType = config.autocorrectionType
        returnKeyType = config.returnKeyType
    }
}
