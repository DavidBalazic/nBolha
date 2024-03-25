//
//  NCButtonViewModelable.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import Foundation

public protocol NCButtonViewModelable: ViewModel {
    var title: String? { get }
    var disabledTitle: String? { get }
}
