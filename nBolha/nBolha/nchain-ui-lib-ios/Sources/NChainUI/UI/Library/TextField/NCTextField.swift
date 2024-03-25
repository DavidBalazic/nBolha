//
//  NCTextField.swift
//  
//
//  Created by Rok Črešnik on 21/08/2023.
//

import UIKit

protocol NCTextFieldDelegate: UITextFieldDelegate {
    func textFieldDidDelete(_ textField: NCTextField)
}

class NCTextField: UITextField {
    weak var myDelegate: NCTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        
        myDelegate?.textFieldDidDelete(self)
    }
}
