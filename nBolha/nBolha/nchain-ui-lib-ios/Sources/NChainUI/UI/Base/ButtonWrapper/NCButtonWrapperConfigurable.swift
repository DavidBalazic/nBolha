//
//  NCButtonWrapperConfigurable.swift
//  
//
//  Created by Rok Črešnik on 17/08/2023.
//

import Foundation

public protocol NCButtonWrapperConfigurable: Configurable {
    associatedtype T: Configurable
    
    var normalState: T { get set }
    var disabledState: T { get set }
    var selectedState: T { get set }
}

public struct NCButtonWrapperConfiguration<T: Configurable>: NCButtonWrapperConfigurable {
    public var normalState: T
    public var disabledState: T
    public var selectedState: T
    
    public init(normalState: T,
                disabledState: T,
                selectedState: T) {
        self.normalState = normalState
        self.disabledState = disabledState
        self.selectedState = selectedState
    }
}
