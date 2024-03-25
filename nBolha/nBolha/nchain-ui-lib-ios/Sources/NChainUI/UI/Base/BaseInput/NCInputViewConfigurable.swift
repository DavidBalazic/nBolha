//
//  NCInputViewConfigurable.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public protocol NCInputViewConfigurable: Configurable {
    var normalState: NCInputViewStateConfiguration { get set }
    var selectedState: NCInputViewStateConfiguration? { get set }
    var errorState: NCInputViewStateConfiguration? { get set }
    var disabledState: NCInputViewStateConfiguration? { get set }
}
