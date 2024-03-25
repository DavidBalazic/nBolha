//
//  NCInputViewModelable.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public protocol NCInputViewModelable: ViewModel {
    var title: String? { get set }
    var value: String? { get set }
    var placeholder: String? { get set }
    var hint: String? { get set }
    var error: String? { get set }
    var info: NCImageViewModel? { get set }
    var leading: NCImageViewModel? { get set }
    var trailing: NCImageViewModel? { get set }
}
