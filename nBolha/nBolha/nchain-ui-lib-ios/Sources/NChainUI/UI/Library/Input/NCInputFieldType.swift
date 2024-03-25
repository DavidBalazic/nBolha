//
//  NCInputFieldType.swift
//  
//
//  Created by Rok Črešnik on 11/08/2023.
//

import UIKit

public enum NCInputFieldType {
    case primary
    case pin
    
    public var config: NCInputViewConfiguration {
        switch self {
        case .primary:
            return .init(normalState: .init(leadingConfiguration: .init(tintColor: .text02)),

                         selectedState: .init(border: .double(color1: .brandPrimary, color2: .inverseOutline02),
                                              leadingConfiguration: .init(tintColor: .icons03)),
                         
                         errorState: .init(hintConfiguration: .init(font: .caption01, textColor: .inverseError),
                                           leadingConfiguration: .init(tintColor: .icons03)),
                         
                         disabledState: .init(.init(tint: .inverseOutline02,
                                                    titleConfiguration: .init(textColor: .inverseOutline02),
                                                    textConfiguration: .init(textColor: .inverseOutline02),
                                                    placeholderConfiguration: .init(textColor: .inverseOutline02),
                                                    hintConfiguration: .init(font: .caption01, textColor: .interactionPrimaryDisabled),
                                                    border: .single(color: .interactionPrimaryDisabled),
                                                    leadingConfiguration: .init(tintColor: .interactionPrimaryDisabled))))
            
        case .pin:
            return Self.primary.config
                .withKeyboardType(type: .decimalPad)
                .withTextAlignment(alignment: .center)
        }
    }
}
