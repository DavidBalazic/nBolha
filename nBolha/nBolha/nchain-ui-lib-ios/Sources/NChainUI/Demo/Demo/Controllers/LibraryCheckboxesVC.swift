//
//  CheckboxesVC.swift
//  Demo
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit
import NChainUI

class LibraryCheckboxesVC: LibraryVC<NCCheckbox> {
    
    override var viewModels: [NCCheckboxViewModel] {
        return [
            .init()
        ]
    }
    
    override var viewConfigs: [NCCheckboxConfiguration]  {
        return [
            NCCheckoxType.primary.config,
        ]
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        stack.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.width.equalTo(40)
        }
    }
}
