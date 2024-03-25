//
//  Marginable.swift
//
//
//  Created by Rok Črešnik on 14/08/2023.
//

import UIKit

/// Protocol for updating margins in Views
public protocol Marginable {
    typealias Margins = NCConstants.Margins
    /// Sets all margins to zero
    func setupClearMargins()
    /// Sets all margins by the same value
    func setupCustomMargins(all: Margins?)
    /// Sets vertical / horizontal margins
    func setupCustomMargins(vertical: Margins?, horizontal: Margins?)
    /// Sets margins individual margins
    func setupCustomMargins(top: Margins?, leading: Margins?, bottom: Margins?, trailing: Margins?)
    
    /// The view that the layout margins should be set
    var marginableView: UIView { get }
}

extension UIView: Marginable {
    
//extension Marginable where Self: UIView {
    public var marginableView: UIView { return self }
    
    public func setupClearMargins() {
        setupCustomMargins(all: .zero)
    }
    
    public func setupCustomMargins(all: Margins?) {
        setupCustomMargins(top: all, leading: all, bottom: all, trailing: all)
    }
    
    public func setupCustomMargins(vertical: Margins? = nil, horizontal: Margins? = nil) {
        setupCustomMargins(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    public func setupCustomMargins(top: Margins? = nil, leading: Margins? = nil, bottom: Margins? = nil, trailing: Margins? = nil) {
        marginableView.preservesSuperviewLayoutMargins = false
        
        if let top = top {
            marginableView.directionalLayoutMargins.top = top.rawValue
        }
        if let bottom = bottom {
            marginableView.directionalLayoutMargins.bottom = bottom.rawValue
        }
        if let leading = leading {
            marginableView.directionalLayoutMargins.leading = leading.rawValue
        }
        if let trailing = trailing {
            marginableView.directionalLayoutMargins.trailing = trailing.rawValue
        }
    }
}
