//
//  NCTextViewConfiguration.swift
//  
//
//  Created by Aleks Krajnik on 29/08/2023.
//

import UIKit

public struct NCTextViewConfiguration: Configurable {
    public var font: UIFont
    public var textColor: UIColor?
    public var textAlignment: NSTextAlignment
    public var isScrollEnabled: Bool
    public var isEditable: Bool
    public var linkTextAttributes: [NSAttributedString.Key : Any]
    
    public init(font: UIFont = .body02,
                textColor: UIColor? = .text02,
                textAlignment: NSTextAlignment = .left,
                isScrollEnabled: Bool = false,
                isEditable: Bool = false,
                linkTextAttributes: [NSAttributedString.Key : Any] = [:]) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.isScrollEnabled = isScrollEnabled
        self.isEditable = isEditable
        self.linkTextAttributes = linkTextAttributes
    }
}
