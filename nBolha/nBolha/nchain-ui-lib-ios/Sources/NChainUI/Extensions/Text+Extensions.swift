//
//  Text+Extensions.swift
//
//
//  Created by Miha Šemrl on 16. 01. 24.
//

import SwiftUI

public protocol TextStyle {
    var font: UIFont { get }
}

extension Text {
    public func textStyle(_ style: TextStyle) -> Self {
        self.font(Font(style.font))
    }
    
    public func textStyle(_ token: UIFont) -> Self {
        self.font(Font(token))
    }
}
