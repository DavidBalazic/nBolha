//
//  UITextView+Extensions.swift
//  
//
//  Created by Aleks Krajnik on 29/08/2023.
//

import UIKit

extension UITextView {
    public func configure(with config: NCTextViewConfiguration?) {
        font = config?.font
        textColor = config?.textColor
        textAlignment = config?.textAlignment ?? .left
        isScrollEnabled = config?.isScrollEnabled ?? false
        isEditable = config?.isEditable ?? false
        linkTextAttributes = config?.linkTextAttributes ?? [:]
    }
    
    public func setup(with viewModel: NCTextViewModel?) {
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
