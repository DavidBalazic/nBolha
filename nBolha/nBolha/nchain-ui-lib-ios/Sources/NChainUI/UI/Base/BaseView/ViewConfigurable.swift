//
//  ViewConfigurable.swift
//  nchain-ui
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

public protocol Configurable {}

public protocol ViewConfigurable {
    associatedtype Config: Configurable
    
    var viewConfig: Config? { get set }
    func configure(with config: Config?)
}
