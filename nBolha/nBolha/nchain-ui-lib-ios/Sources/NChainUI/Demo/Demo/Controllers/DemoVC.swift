//
//  File.swift
//  Demo
//
//  Created by Rok Črešnik on 17/08/2023.
//

import UIKit
import NChainUI

class DemoVC: LibraryVC<NCButtonWrapperView<AccessoryTitleView, AccessoryTitleButtonConfiguration>> {
    
    override var viewModels: [AccessoryTitleViewModel] {
        return [
            .init(title: .text("test"),
                  leading: .icon(.icnCheckbox),
                  trailing: .icon(.icnCheckboxSelected)),
            .init(title: .attributedText(.init(string: "test", attributes: [ .underlineStyle: NSUnderlineStyle.single.rawValue ])),
                  leading: .icon(.icnCheckbox),
                  trailing: .icon(.icnCheckboxSelected)),
            .init(title: .text("test"),
                  leading: .icon(.icnCheckbox),
                  trailing: .icon(.icnCheckboxSelected)),
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
        
        stack.snp.removeConstraints()
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        var counter = 0
        for case let button as NCButtonWrapperView<AccessoryTitleView, AccessoryTitleButtonConfiguration> in stack.arrangedSubviews {
            button.setup { $0.axis = counter % 2 == 0 ? .vertical : .horizontal }
            counter += 1
        }
    }
}
