//
//  AccessoryTitleViewConfiguration.swift
//  
//
//  Created by Rok Črešnik on 17/08/2023.
//

import UIKit

public struct AccessoryTitleButtonConfiguration: NCButtonWrapperConfigurable {
    public var normalState: AccessoryTitleViewConfiguration
    public var selectedState: AccessoryTitleViewConfiguration
    public var disabledState: AccessoryTitleViewConfiguration
    
    public init(normalState: AccessoryTitleViewConfiguration, selectedState: AccessoryTitleViewConfiguration, disabledState: AccessoryTitleViewConfiguration) {
        self.normalState = normalState
        self.selectedState = selectedState
        self.disabledState = disabledState
    }
    
    // TODO: discontinue use!
    public init(from buttonType: NCButtonType) {
        normalState = .init(titleColor: buttonType.config.normalState.textColor,
                            tintColor: buttonType.config.normalState.textColor,
                            border: buttonType.config.normalState.borderConfig,
                            backgroundColor: buttonType.config.normalState.backgroundColor)

        selectedState = .init(titleColor: buttonType.config.selectedState?.textColor,
                              tintColor: buttonType.config.selectedState?.textColor,
                              border: buttonType.config.selectedState?.borderConfig,
                              backgroundColor: buttonType.config.selectedState?.backgroundColor)

        disabledState = .init(titleColor: buttonType.config.disabledState?.textColor,
                              tintColor: buttonType.config.disabledState?.textColor,
                              border: buttonType.config.disabledState?.borderConfig,
                              backgroundColor: buttonType.config.disabledState?.backgroundColor)
    }
}

public struct AccessoryTitleViewConfiguration: SteteConfigurable {
    public var title: NCLabelConfiguration?
    public var accessory: NCBaseViewConfiguration?
    public var border: NChainUI.NCBorderConfiguration?
    
    public init(title: NCLabelConfiguration? = nil, accessory: NCBaseViewConfiguration? = nil, border: NChainUI.NCBorderConfiguration? = nil) {
        self.title = title
        self.accessory = accessory
        self.border = border
    }
    
    public init(titleColor: UIColor?, tintColor: UIColor?, border: NCBorderConfiguration?, backgroundColor: UIColor?) {
        title = .init(textColor: titleColor, textAlignment: .center)
        accessory = .init(tintColor: tintColor ?? titleColor)
        self.border = border ?? .init(color: .clear, background: backgroundColor)
    }
}
