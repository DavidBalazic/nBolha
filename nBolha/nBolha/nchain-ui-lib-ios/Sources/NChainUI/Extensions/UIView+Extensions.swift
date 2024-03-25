//
//  UIView+Bordered.swift
//  
//
//  Created by Rok Črešnik on 10/08/2023.
//

import UIKit

extension UIView {
    public func withBorder(_ border: NCBorderConfiguration = .init()) -> UIView {
        let view = BorderView(contentView: self)
        view.configure(with: border)
        return view
    }
    
    public func withShadow(_ shadow: ShadowConfiguration = .init()) -> UIView {
        let view = ShadowView(contentView: self)
        view.shadow = shadow
        return view
    }
}
