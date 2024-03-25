//
//  NCBorderConfiguration.swift
//  
//
//  Created by Rok Črešnik on 10/08/2023.
//

import UIKit

public struct NCBorderConfiguration: Configurable {
    public var color: UIColor?
    public var width: CGFloat
    public var outerColor: UIColor?
    public var outerWidth: CGFloat
    public var radius: CGFloat
    public var background: UIColor?
    
    public init(color: UIColor? = .outline03,
                width: CGFloat = 1,
                outerColor: UIColor? = nil,
                outerWidth: CGFloat = 3,
                radius: NCConstants.Radius = .small,
                background: UIColor? = .clear) {
        self.color = color
        self.width = width
        self.outerColor = outerColor
        self.outerWidth = outerWidth
        self.radius = radius.rawValue
        self.background = background
    }
    
    public func with(background color: UIColor?) -> NCBorderConfiguration {
        var config = self
        config.background = color
        return config
    }
}
