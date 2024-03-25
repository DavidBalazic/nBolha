//
//  NCPinInputViewModel.swift
//  
//
//  Created by Rok Črešnik on 21/08/2023.
//

import UIKit

public struct NCPinInputViewModel: ViewModel {
    var status: String?
    var error: String?
    
    public init(status: String? = nil, error: String? = nil) {
        self.status = status
        self.error = error
    }
}
