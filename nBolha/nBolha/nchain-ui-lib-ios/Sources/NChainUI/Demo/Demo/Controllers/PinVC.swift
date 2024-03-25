//
//  PinVC.swift
//  Demo
//
//  Created by Rok Črešnik on 18/08/2023.
//

import UIKit
import NChainUI

class PinVC: LibraryVC<NCPinInputView> {
    
    private lazy var button: NCButton = {
        let button = NCButton()
        button.setup(with: .init(title: .text("continue")))
        button.configure(with: .init(from: .primary))
        button.isEnabled = false
  
        return button
    }()
    
    override var viewModels: [NCPinInputViewModel] {
        return [
            .init(status: "Please enter your pin", error: "Pin invalid")
        ]
    }
    
    override var viewConfigs: [NCInputViewConfiguration] {
        return [
            NCInputFieldType.pin.config
        ]
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        stack.addArrangedSubview(button)
        
        items.first?.didFinish = { [weak self] value in
            guard value == "000000" else {
                self?.items.first?.displayState = .error
                return
            }
            self?.items.first?.displayState = .normal
        }
        
        items.first?.didUpdate = { [weak self] value in
            self?.button.isEnabled = value?.count == 6
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = items.first?.becomeFirstResponder()
    }
}
