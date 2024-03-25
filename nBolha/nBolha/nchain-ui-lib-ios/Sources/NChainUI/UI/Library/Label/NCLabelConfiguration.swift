//
//  NCLabelConfiguration.swift
//  
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

public struct NCLabelConfiguration: Configurable {
    public var font: UIFont
    public var textColor: UIColor?
    public var textAlignment: NSTextAlignment
    public var numberOfLines: Int
    public var lineBreakMode: NSLineBreakMode
    public var isUserInteractionEnabled: Bool
    
    public init(font: UIFont = .body02,
                textColor: UIColor? = .text02,
                textAlignment: NSTextAlignment = .left,
                numberOfLines: Int = 0,
                lineBreakMode: NSLineBreakMode = .byWordWrapping,
                isUserInteractionEnabled: Bool = false) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
}
