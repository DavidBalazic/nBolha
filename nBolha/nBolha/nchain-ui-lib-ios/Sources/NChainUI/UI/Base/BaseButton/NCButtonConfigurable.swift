//
//  NCButtonConfigurable.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import Foundation

public protocol NCButtonConfigurable: Configurable {
    var normalState: NCButtonStateConfiguration { get }
    var disabledState: NCButtonStateConfiguration? { get }
    var selectedState: NCButtonStateConfiguration? { get }
    var size: ButtonSize? { get }
}
