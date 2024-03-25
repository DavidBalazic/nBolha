//
//  ViewModelable.swift
//  nchain-ui
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

public protocol ViewModel: Hashable {}

public protocol ViewModelable {
    associatedtype VM: ViewModel
    var viewModel: VM? { get set }
    func setup(with model: VM?)
}
