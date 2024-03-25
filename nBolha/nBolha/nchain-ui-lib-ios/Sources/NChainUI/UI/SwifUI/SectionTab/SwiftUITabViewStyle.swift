//
//  SwiftUITabViewStyle.swift
//  
//
//  Created by Miha Šemrl on 29. 01. 24.
//

import SwiftUI

public struct SwiftUITabViewStyle {
    var selectedBackgroundColor: Color
    var selectedUnderlineColor: Color
    var selectedTextColor: Color
    var selectedFont: UIFont
    var unselectedBackgroundColor: Color
    var unselectedUnderlineColor: Color
    var unselectedTextColor: Color
    var unselectedFont: UIFont
    
    public init(
        selectedBackgroundColor: Color,
        selectedUnderlineColor: Color,
        selectedTextColor: Color,
        selectedFont: UIFont,
        unselectedBackgroundColor: Color?,
        unselectedUnderlineColor: Color?,
        unselectedTextColor: Color,
        unselectedFont: UIFont
    ) {
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedUnderlineColor = selectedUnderlineColor
        self.selectedTextColor = selectedTextColor
        self.selectedFont = selectedFont
        self.unselectedBackgroundColor = unselectedBackgroundColor ?? .clear
        self.unselectedUnderlineColor = unselectedUnderlineColor ?? .clear
        self.unselectedTextColor = unselectedTextColor
        self.unselectedFont = unselectedFont
    }
}

public let tabViewDefaultStyle = SwiftUITabViewStyle(
    selectedBackgroundColor: Color(.background05),
    selectedUnderlineColor: Color(.brandSecondary),
    selectedTextColor: Color(.text01),
    selectedFont: .body03,
    unselectedBackgroundColor: .clear,
    unselectedUnderlineColor: .clear,
    unselectedTextColor: Color(.text02),
    unselectedFont: .body03
)
