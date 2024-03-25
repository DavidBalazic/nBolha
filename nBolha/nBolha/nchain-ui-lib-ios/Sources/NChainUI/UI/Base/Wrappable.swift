//
//  Wrappable.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public protocol Wrappable: UIView {
    associatedtype V: BaseViewProtocol
    
    var wrappedView: V { get set }
}
