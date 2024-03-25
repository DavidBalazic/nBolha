//
//  File.swift
//  
//
//  Created by Rok Črešnik on 10/08/2023.
//

import UIKit

public struct ShadowConfiguration: Configurable {
    public var color: UIColor
    public var offset: CGSize
    public var opacity: Float
    public var radius: CGFloat
    
    public init(color: UIColor = .black,
                offset: CGSize = .init(width: NCConstants.Margins.extraSmall.rawValue,
                                       height: NCConstants.Margins.extraSmall.rawValue),
                opacity: Float = NCConstants.Opacity.medium.rawValue,
                radius: CGFloat = NCConstants.Radius.small.rawValue) {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }
}
