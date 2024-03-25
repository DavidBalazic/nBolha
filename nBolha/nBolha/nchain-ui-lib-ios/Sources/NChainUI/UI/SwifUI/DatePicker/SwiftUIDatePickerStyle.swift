//
//  SwiftUIDatePickerStyle.swift
//
//
//  Created by Miha Šemrl on 27. 02. 24.
//

import SwiftUI

public struct SwiftUIDatePickerStyle {
    var titleFont: UIFont
    var titleColor: Color
    var dateFont: UIFont
    var dateColor: Color
    var borderColor: Color
    var iconColor: Color
    
    public init(
        titleFont: UIFont = .caption01,
        titleColor: Color? = nil,
        dateFont: UIFont = .body02,
        dateColor: Color? = nil,
        borderColor: Color? = nil,
        iconColor: Color? = nil
    ) {
        self.titleFont = titleFont
        self.titleColor = titleColor ?? Color(.text02)
        self.dateFont = dateFont
        self.dateColor = dateColor ?? Color(.text02)
        self.borderColor = borderColor ?? Color(.outline03)
        self.iconColor = iconColor ?? Color(.icons03)
    }
}
