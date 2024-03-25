//
//  NCButton.swift
//  
//
//  Created by Miha Šemrl on 09/08/2023.
//

import UIKit

public final class NCButton: NCButtonWrapperView<AccessoryTitleView, AccessoryTitleButtonConfiguration> {
    public override func configure(with config: AccessoryTitleButtonConfiguration?) {
        var copy = config
        
        if let font = config?.normalState.title?.font.withSize(buttonSize.titleFontSize) {
            // config title font size depending on button size
            copy?.normalState.title?.font = font
            copy?.selectedState.title?.font = font
            copy?.disabledState.title?.font = font
        }
        
        super.configure(with: copy)
    }
}
