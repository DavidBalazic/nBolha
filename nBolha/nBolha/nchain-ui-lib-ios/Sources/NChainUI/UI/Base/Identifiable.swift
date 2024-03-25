//
//  Identifiable.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public protocol Identifiable {
    static var identifier: String { get }
    static var className: AnyClass { get }
}

extension Identifiable where Self: UIView {
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static var className: AnyClass {
        return Self.self
    }
}
