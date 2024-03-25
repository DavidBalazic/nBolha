//
//  NCCheckoxType.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public enum NCCheckoxType {
    /// gray tint
    case primary
    
    public var config: NCCheckboxConfiguration {
        switch self {
        case .primary:
            return .init(normalState: .init(backgroundColor: .clear, textColor: .brandTertiary),
                         disabledState: .init(backgroundColor: .clear, textColor: .interactionPrimaryDisabled),
                         selectedState: .init(backgroundColor: nil,
                                              textColor: .brandTertiary,
                                              borderConfig: .init(color: .clear,
                                                                  radius: .large,
                                                                  background: .brandTertiary?.withAlphaComponent(NCConstants.Opacity.low.value))),
                         size: .small)
        }
    }
}
