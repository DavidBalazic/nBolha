//
//  UILabel+Configurable.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

extension UILabel {
    public func configure(with config: NCLabelConfiguration?) {
        font = config?.font
        textColor = config?.textColor
        textAlignment = config?.textAlignment ?? .left
        numberOfLines = config?.numberOfLines ?? 0
        lineBreakMode = config?.lineBreakMode ?? .byWordWrapping
        isUserInteractionEnabled = config?.isUserInteractionEnabled ?? false
    }
    
    public func setup(with viewModel: NCLabelViewModel?) {
        switch viewModel {
        case .text(let string):
            text = string
            
        case .attributedText(let attributedString):
            attributedText = attributedString
            
        default:
            return
        }
    }
}
