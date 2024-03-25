//
//  NCCollectionViewCell.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

open class NCCollectionViewCell<V: ViewModel, C:Configurable>: UICollectionViewCell,
                                                               Identifiable,
                                                               StateDisplayable,
                                                               BaseViewProtocol {
    
    // MARK: NCViewProtocol
    public var displayState: DisplayState = .normal
    public var radius: NCConstants.Radius
    
    public var viewModel: V?
    public var viewConfig: C?
    
    // MARK: Overrides
    open override var isSelected: Bool {
        didSet {
            animateTo(state: isSelected ? .selected : .normal, withAnimation: true)
        }
    }
    
    open override var isHighlighted: Bool {
        didSet {
            animateTo(state: isHighlighted ? .selected : .normal, withAnimation: true)
        }
    }
    
    // MARK: - Initialization
    public required override init(frame: CGRect = .zero) {
        self.radius = .zero
        super.init(frame: .zero)
        setupSubviews()
    }
    
    public required init(radius: NCConstants.Radius = .zero) {
        self.radius = radius
        super.init(frame: .zero)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        self.radius = .zero
        super.init(coder: coder)
        setupSubviews()
    }
    
    // MARK: View setup
    public func setupSubviews() {}
    
    public func configure(with config: C?) {
        self.viewConfig = config
        backgroundColor = .clear
    }
    
    public func setup(with viewModel: V?) {
        self.viewModel = viewModel
    }
    
    // MARK: StateDisplayable
    public func animateTo(state: DisplayState, withAnimation: Bool = true) {
        guard let config = viewConfig as? NCButtonConfiguration else { return }
        
        let background: UIColor?
        let tint: UIColor?
        switch state {
        case .normal:
            background = config.normalState.backgroundColor
            tint = config.normalState.textColor
            
        case .selected:
            background = config.selectedState?.backgroundColor
            tint = config.selectedState?.textColor
            
        case .disabled:
            background = config.disabledState?.backgroundColor
            tint = config.disabledState?.textColor
            
        default: return
        }
        
        UIView.animate(withDuration: NCConstants.AnimationDuration.medium.rawValue) { [unowned self] in
            marginableView.backgroundColor = background
            tintColor = tint
        }
    }
    
    // MARK: Reusable
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        viewConfig = nil
    }
}
