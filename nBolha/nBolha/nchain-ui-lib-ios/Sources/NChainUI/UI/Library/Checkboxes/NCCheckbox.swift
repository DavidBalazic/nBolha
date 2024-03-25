//
//  NCCheckbox.swift
//  
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

public final class NCCheckbox: NCBaseButton<NCCheckboxViewModel, NCCheckboxConfiguration> {
    public var type: NCCheckoxType = .primary {
        didSet {
            configure(with: type.config.withSize(size: .small))
        }
    }
    
    public override func setupSubviews() {
        super.setupSubviews()
        setImage(.init(named: "icnCheckbox", in: Bundle.module, compatibleWith: nil), for: .normal)
        setImage(.init(named: "icnCheckbox", in: Bundle.module, compatibleWith: nil), for: .normal.union(.highlighted))
        setImage(.init(named: "icnCheckboxSelected", in: Bundle.module, compatibleWith: nil), for: .selected)
        setImage(.init(named: "icnCheckboxSelected", in: Bundle.module, compatibleWith: nil), for: .selected.union(.highlighted))
    }
    
    @objc override func tapped() {
        isSelected.toggle()
        super.tapped()
    }
}
