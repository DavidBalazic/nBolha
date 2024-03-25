//
//  NCButtonStateConfiguration.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public protocol NCButtonStateConfigurable: Configurable {
    var backgroundColor: UIColor? { get set }
    var textColor: UIColor? { get set }
    var textUnderline: Bool? { get set }
    var borderConfig: NCBorderConfiguration? { get set }
}

public struct NCButtonStateConfiguration: NCButtonStateConfigurable {
    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public var textUnderline: Bool?
    public var borderConfig: NCBorderConfiguration?
    //TODO: add shadows
    
    public init(backgroundColor: UIColor?, textColor: UIColor?, textUnderline: Bool? = false, borderConfig: NCBorderConfiguration? = nil) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.textUnderline = textUnderline
        self.borderConfig = borderConfig
    }
}
