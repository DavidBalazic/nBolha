//
//  NCBaseViewConfiguration.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

public struct NCBaseViewConfiguration: Configurable {
    public var tintColor: UIColor?
    public var backgroundColor: UIColor?
    
    public init(tintColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
}
