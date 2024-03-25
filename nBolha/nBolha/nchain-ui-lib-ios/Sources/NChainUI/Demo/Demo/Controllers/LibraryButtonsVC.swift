//
//  LibraryButtonsVC.swift
//  Demo
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit
import NChainUI

class LibraryButtonsVC: LibraryVC<NCButton> {
    
    override var viewModels: [AccessoryTitleViewModel] {
        return [
            .init(title: .text("test"),
                  trailing: .icon(.icnCheckboxSelected)),
            
            .init(title: .attributedText(.init(string: "test", attributes: [ .underlineStyle: NSUnderlineStyle.single.rawValue ]))),
            
            .init(leading: .icon(.icnCheckboxSelected)),
            
            .init(title: .text("test"),
                  leading: .icon(.icnCheckbox),
                  trailing: .icon(.icnCheckboxSelected))
        ]
    }
    
    override var viewConfigs: [AccessoryTitleButtonConfiguration] {
        return [
            .init(from: .primary),
            .init(from: .link),
            .init(from: .outlined),
            .init(from: .text)
        ]
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        for case let button as NCButton in stack.arrangedSubviews {
            button.setupCustomMargins(all: .medium)
        }
    }
}
