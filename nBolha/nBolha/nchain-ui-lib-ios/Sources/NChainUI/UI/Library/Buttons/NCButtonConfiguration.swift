//
//  NCButtonConfiguration.swift
//  
//
//  Created by Miha Šemrl on 09/08/2023.
//

import UIKit

public enum ButtonSize {
    case large
    case small
    case link
    
    var padding: NCConstants.Margins {
        switch self {
        case .large:
            return NCConstants.Margins.medium
            
        case .small:
            return NCConstants.Margins.small
            
        case .link:
            return NCConstants.Margins.zero
        }
    }
    
    var titleFontSize: Double {
        switch self {
        case .large:
            return 16
            
        case .small:
            return 14
            
        case .link:
            return 14
        }
    }
}

public struct NCButtonConfiguration: NCButtonConfigurable {
    public var normalState: NCButtonStateConfiguration
    public var disabledState: NCButtonStateConfiguration?
    public var selectedState: NCButtonStateConfiguration?
    public var size: ButtonSize?
    
    public init(normalState: NCButtonStateConfiguration,
                disabledState: NCButtonStateConfiguration? = nil,
                selectedState: NCButtonStateConfiguration? = nil,
                size: ButtonSize? = .small) {
        self.normalState = normalState
        self.disabledState = disabledState
        self.selectedState = selectedState
        self.size = size
    }
    
    public func withSize(size: ButtonSize?) -> NCButtonConfiguration {
        var config = self
        config.size = size
        return config
    }
}
