//
//  NCButtonType.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import Foundation

// TODO: this configurations are not 100% yet!
public enum NCButtonType {
    case primary
    case outlined
    case text
    case link
    case custom(NCButtonConfiguration)
    
    public var config: NCButtonConfiguration {
        switch self {
        case .primary:
            return .init(normalState: .init(backgroundColor: .brandPrimary,
                                            textColor: .inverseText01),
                         disabledState: .init(backgroundColor: .interactionPrimaryDisabled,
                                              textColor: .inverseText01),
                         selectedState: .init(backgroundColor: .contrast03,
                                              textColor: .brandTertiary))
        case .outlined:
            return .init(normalState: .init(backgroundColor: .clear,
                                            textColor: .brandPrimary,
                                            borderConfig: .init(color: .brandPrimary)),
                         disabledState: .init(backgroundColor: .clear,
                                              textColor: .interactionPrimaryDisabled,
                                              borderConfig: .init(color: .interactionPrimaryDisabled)),
                         selectedState: .init(backgroundColor: .clear,
                                              textColor: .brandTertiary,
                                              borderConfig: .init(color: .interactionPrimaryFocus)))
        case .text:
            return .init(normalState: .init(backgroundColor: .clear,
                                            textColor: .brandPrimary,
                                            borderConfig: .init(color: .clear)),
                         disabledState: .init(backgroundColor: .clear,
                                              textColor: .interactionPrimaryDisabled,
                                              borderConfig: .init(color: .clear)),
                         selectedState: .init(backgroundColor: .clear,
                                              textColor: .brandTertiary,
                                              borderConfig: .init(color: .interactionPrimaryFocus)))
        case .link:
            return .init(normalState: .init(backgroundColor: .clear,
                                            textColor: .brandPrimary,
                                            textUnderline: true),
                         disabledState: .init(backgroundColor: .clear,
                                              textColor: .interactionPrimaryDisabled,
                                              textUnderline: true),
                         selectedState: .init(backgroundColor: .clear,
                                              textColor: .brandTertiary,
                                              textUnderline: true))
        case .custom(let config):
            return config
        }
    }
}
