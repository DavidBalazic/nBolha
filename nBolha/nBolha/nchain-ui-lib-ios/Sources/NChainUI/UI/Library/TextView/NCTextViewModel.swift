//
//  NCTextViewModel.swift
//  
//
//  Created by Aleks Krajnik on 29/08/2023.
//

import UIKit

public enum NCTextViewModel: ViewModel {
    case text(String?)
    case attributedText(NSAttributedString?)
}
