//
//  NCInputView.swift
//  
//
//  Created by Rok Črešnik on 15/08/2023.
//

import Foundation

public final class NCInputView: NCBaseInputView<NCInputViewModel, NCInputViewConfiguration> {
    public var type: NCInputFieldType = .primary {
        didSet {
            configure(with: type.config)
        }
    }
}
