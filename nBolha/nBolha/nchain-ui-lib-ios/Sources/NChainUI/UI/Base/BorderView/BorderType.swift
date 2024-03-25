//
//  BorderType.swift
//  
//
//  Created by Rok Črešnik on 17/08/2023.
//

import UIKit

public enum BorderType: Configurable {
    case none
    case single(color: UIColor?)
    case double(color1: UIColor?, color2: UIColor?)
    
    public var config: NCBorderConfiguration? {
        switch self {
        case .none: return .init(width: 0)
            
        case .single(let color):
            return .init(color: color)
            
        case .double(let color1, let color2):
            return .init(color: color1, outerColor: color2)
        }
    }
}
