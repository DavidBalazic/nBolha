//
//  File.swift
//  
//
//  Created by Miha Šemrl on 22. 01. 24.
//

import SwiftUI

public struct ChipViewStyle {
    var selectedBackgroundColor: Color
    var selectedBorderColor: Color
    var selectedTintColor: Color
    var unselectedBackgroundColor: Color
    var unselectedBorderColor: Color
    var unselectedTintColor: Color
    var disabledBackgroundColor: Color
    var disabledBorderColor: Color
    var disabledTintColor: Color
    
    public init(selectedBackgroundColor: Color,
                selectedBorderColor: Color,
                selectedTintColor: Color,
                unselectedBackgroundColor: Color,
                unselectedBorderColor: Color,
                unselectedTintColor: Color,
                disabledBackgroundColor: Color?,
                disabledBorderColor: Color? ,
                disabledTintColor: Color?) {
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedBorderColor = selectedBorderColor
        self.selectedTintColor = selectedTintColor
        self.unselectedBackgroundColor = unselectedBackgroundColor
        self.unselectedBorderColor = unselectedBorderColor
        self.unselectedTintColor = unselectedTintColor
        self.disabledBackgroundColor = disabledBackgroundColor ?? .white
        self.disabledBorderColor = disabledBorderColor ?? Color(.inverseOutline01)
        self.disabledTintColor = disabledTintColor ?? Color(.inverseOutline01)
    }
    
    public init(
        disabledBackgroundColor: Color?,
        disabledBorderColor: Color?,
        disabledTintColor: Color?
    ) {
        self.selectedBackgroundColor = Color(.background05)
        self.selectedBorderColor = .clear
        self.selectedTintColor = Color(.brandSecondary)
        self.unselectedBackgroundColor = .white
        self.unselectedBorderColor = Color(.brandSecondary)
        self.unselectedTintColor = Color(.brandSecondary)
        self.disabledBackgroundColor = disabledBackgroundColor ?? .white
        self.disabledBorderColor = disabledBorderColor ?? Color(.inverseOutline01)
        self.disabledTintColor = disabledTintColor ?? Color(.inverseOutline01)
    }
}

public let chipViewDefaultStyle = ChipViewStyle(
    selectedBackgroundColor: Color(.background05),
    selectedBorderColor: .clear,
    selectedTintColor: Color(.brandSecondary),
    unselectedBackgroundColor: .white,
    unselectedBorderColor: Color(.brandSecondary),
    unselectedTintColor: Color(.brandSecondary),
    disabledBackgroundColor: .white,
    disabledBorderColor: Color(.inverseOutline01),
    disabledTintColor: Color(.inverseOutline01)
)
