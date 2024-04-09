//
//  NCConstants.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import Foundation

public struct NCConstants {
    /// Used for offseting views and/or default height/widths
    public enum Margins: CGFloat {
        /// 0
        case zero = 0
        /// 4
        case extraSmall = 4
        /// 8
        case small = 8
        /// 12
        case medium = 12
        /// 16
        case large = 16
        /// 24
        case extraLarge = 24
        /// 32
        case huge = 32
        /// 40
        case extraHuge = 40
        /// 44
        case veryHuge = 44
        /// 48
        case giant = 48
        /// 64
        case extraGiant = 64
    }
    
    /// Animation durations
    public enum AnimationDuration: CGFloat {
        /// 0.25 s
        case short = 0.25
        /// 0.35 s
        case medium = 0.35
        /// 0.45 s
        case long = 0.45
    }
    
    /// View opacity/transaprency 
    public enum Opacity: Float {
        /// 0.2
        case low = 0.2
        /// 0.5
        case medium = 0.5
        
        public var value: CGFloat {
            return CGFloat(rawValue)
        }
    }
    
    public enum Radius: CGFloat {
        /// 0
        case zero = 0.0
        /// 4
        case extraSmall = 4.0
        /// 8
        case small = 8.0
        /// 12
        case medium = 12.0
        /// 20
        case large = 20.0
    }
    
    public enum ButtonHeight: CGFloat {
        case `default` = 48
        case small = 32
    }
    
    public enum IconSize: CGFloat {
        /// 12
        case small = 12
        /// 16
        case medium = 16
        /// 18
        case large = 18
        /// 24
        case huge = 24
    }
    
    public enum ViewOrientation {
        case horizontal
        case vertical
    }
}
