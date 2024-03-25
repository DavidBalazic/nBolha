//
//  File.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit

/// Protocol for any UI element, that shows different states.
/// Note: Not all states need to be implemented
public enum DisplayState {
    case normal
    case selected
    case disabled
    case error
}

public protocol StateDisplayable {
    var displayState: DisplayState { get set }
    func animateTo(state: DisplayState, withAnimation: Bool)
    
    func animateToNormal(with duration: CGFloat)
    func animateToSelected(with duration: CGFloat)
    func animateToError(with duration: CGFloat)
    func animateToDisabled(with duration: CGFloat)
}


extension StateDisplayable where Self: UIView {
    public func animateTo(state: DisplayState, withAnimation: Bool = true) {
        let duration: CGFloat = withAnimation ? NCConstants.AnimationDuration.medium.rawValue : 0
        switch state {
        case .normal:
            animateToNormal(with: duration)
            
        case .selected:
            animateToSelected(with: duration)
            
        case .disabled:
            animateToDisabled(with: duration)
            
        case .error:
            animateToError(with: duration)
        }
    }
    
    public func animateToNormal(with duration: CGFloat) {}
    public func animateToSelected(with duration: CGFloat) {}
    public func animateToError(with duration: CGFloat) {}
    public func animateToDisabled(with duration: CGFloat) {}
}
