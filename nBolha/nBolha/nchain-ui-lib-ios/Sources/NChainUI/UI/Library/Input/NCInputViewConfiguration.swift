//
//  NCInputViewConfiguration.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

public struct NCInputViewConfiguration: NCInputViewConfigurable {
    public var normalState: NCInputViewStateConfiguration
    public var selectedState: NCInputViewStateConfiguration?
    public var errorState: NCInputViewStateConfiguration?
    public var disabledState: NCInputViewStateConfiguration?
    
    public init(normalState: NCInputViewStateConfiguration = .init(),
                selectedState: NCInputViewStateConfiguration? = nil,
                errorState: NCInputViewStateConfiguration? = nil,
                disabledState: NCInputViewStateConfiguration? = nil) {
        self.normalState = normalState
        self.selectedState = selectedState
        self.errorState = errorState
        self.disabledState = disabledState
    }
    
    public func withKeyboardType(type: UIKeyboardType) -> NCInputViewConfiguration {
        var copy = self
        copy.normalState.textConfiguration?.keyboardType = type
        copy.selectedState?.textConfiguration?.keyboardType = type
        copy.errorState?.textConfiguration?.keyboardType = type
        copy.disabledState?.textConfiguration?.keyboardType = type
        return copy
    }
    
    public func withTextAlignment(alignment: NSTextAlignment) -> NCInputViewConfiguration {
        var copy = self
        copy.normalState.textConfiguration?.textAlignment = alignment
        copy.selectedState?.textConfiguration?.textAlignment = alignment
        copy.errorState?.textConfiguration?.textAlignment = alignment
        copy.disabledState?.textConfiguration?.textAlignment = alignment
        return copy
    }
    
    public func withReturnKeyType(returnKeyType: UIReturnKeyType) -> NCInputViewConfiguration {
        var copy = self
        copy.normalState.textConfiguration?.returnKeyType = returnKeyType
        copy.selectedState?.textConfiguration?.returnKeyType = returnKeyType
        copy.errorState?.textConfiguration?.returnKeyType = returnKeyType
        copy.disabledState?.textConfiguration?.returnKeyType = returnKeyType
        return copy
    }
}

public struct NCViewMargingsConfiguration {
    public var vertical: NCConstants.Margins
    public var horizontal: NCConstants.Margins
    
    public init(vertical: NCConstants.Margins, horizontal: NCConstants.Margins) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
}
