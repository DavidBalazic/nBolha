//
//  NCInputViewStateConfiguration.swift
//  
//
//  Created by Rok Črešnik on 11/08/2023.
//

import UIKit

public struct NCInputViewStateConfiguration: Configurable {
    public var tint: UIColor?
    public var background: UIColor?
    
    public var titleConfiguration: NCLabelConfiguration?
    public var textConfiguration: NCTextFieldConfiguration?
    public var placeholderConfiguration: NCLabelConfiguration?
    public var hintConfiguration: NCLabelConfiguration?
    public var borderConfiguration: NCBorderConfiguration?
    public var leadingConfiguration: NCBaseViewConfiguration?
    public var trailingConfiguration: NCBaseViewConfiguration?
    public var errorViewConfiguration: NCBaseViewConfiguration?
    public var marginsConfiguration: NCViewMargingsConfiguration?
    
    public init(tint: UIColor? = .text02,
                background: UIColor? = nil,
                titleConfiguration: NCLabelConfiguration? = .init(font: .caption01),
                textConfiguration: NCTextFieldConfiguration? = .init(),
                placeholderConfiguration: NCLabelConfiguration? = .init(textColor: .text02),
                hintConfiguration: NCLabelConfiguration? = .init(font: .caption01),
                border: BorderType = .single(color: .outline03),
                borderConfiguration: NCBorderConfiguration? = nil,
                leadingConfiguration: NCBaseViewConfiguration? = nil,
                trailingConfiguration: NCBaseViewConfiguration? = nil,
                errorViewConfiguration: NCBaseViewConfiguration? = nil,
                marginsConfiguration: NCViewMargingsConfiguration? = nil) {
        self.tint = tint
        self.background = background
        self.titleConfiguration = titleConfiguration
        self.textConfiguration = textConfiguration
        self.placeholderConfiguration = placeholderConfiguration
        self.hintConfiguration = hintConfiguration
        self.borderConfiguration = borderConfiguration != nil ? borderConfiguration : border.config?.with(background: background)
        self.leadingConfiguration = leadingConfiguration
        self.trailingConfiguration = trailingConfiguration
        self.errorViewConfiguration = errorViewConfiguration
        self.marginsConfiguration = marginsConfiguration
    }
}
