//
//  InputsVC.swift
//  Demo
//
//  Created by Rok Črešnik on 15/08/2023.
//

import UIKit
import NChainUI

class LibraryInputsVC: LibraryVC<NCInputView> {
    
    override var viewModels: [NCInputViewModel] {
        return [
            .init(title: "Email", hint: "Enter your email",  error: "No value or invalid input", trailing: .icon(.icnCheckbox)),
            .init(title: "Email", placeholder: "Enter your email", error: "No value or invalid input", leading: .icon(.icnUser)),
            .init(title: "Email", hint: "I wonder who could help you?", trailing: .animation(NCAnimation.warning.animation, .loop)),
            .init(title: "Email", trailing: .animation(NCAnimation.warning.animation, .loop)),
        ]
    }
    
    override var viewConfigs: [NCInputViewConfiguration]  {
        return [
            NCInputFieldType.primary.config,
            NCInputFieldType.primary.config,
            NCInputFieldType.primary.config,
            NCInputFieldType.primary.config
        ]
    }
    
    override func setupInteractions() {
        super.setupInteractions()
        var selected = false
        for item in items {
            item.onResize = { self.view.layoutIfNeeded() }
            
            item.valueChanged = { tf in
                guard tf.text?.isEmpty == false else {
                    item.animateTo(state: .error)
                    return
                }
                item.animateTo(state: .selected)
            }
            
            item.finishedEditing = { tf in
                guard tf.text?.isEmpty == false else {
                    item.animateTo(state: .error)
                    return
                }
                item.animateTo(state: .normal)
            }
            
            item.didTapTrailingView = { view in
                switch view?.viewModel {
                case .icon:
                    selected.toggle()
                    view?.setup(with: .icon(selected ? .icnCheckboxSelected : .icnCheckbox))
                    item.isSecureTextEntry = selected
                    
                default:
                    print("tapped")
                }
            }
        }
    }
}
