//
//  NCBaseButton.swift
//  
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

open class NCBaseButton<VM: NCButtonViewModelable, C: NCButtonConfigurable>: UIButton, BaseViewProtocol, StateDisplayable {
    public var viewModel: VM?
    public var viewConfig: C?
    public var displayState: DisplayState = .normal
    private var border: NCBorderConfiguration?
    
    public var onTap: ((UIButton) -> Void)?
    
    public override var isHighlighted: Bool {
        didSet {
            animateTo(state: isHighlighted ? .selected : .normal, withAnimation: true)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            animateTo(state: isEnabled ? .normal : .disabled, withAnimation: true)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        drawBorder()
    }

    open func setupSubviews() {
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        layer.cornerRadius = NCConstants.Radius.small.rawValue
        titleLabel?.font = .subtitle03
    }

    @objc func tapped() {
        onTap?(self)
    }
    
    open func setup(with model: VM?) {
        viewModel = model
        setTitle(model?.title, for: .normal)
        if let title = model?.disabledTitle {
            setTitle(title, for: .disabled)
        }
        
        setUnderlineForAll(for: viewConfig)
    }
    
    open func configure(with config: C?) {
        viewConfig = config
        
        let padding = (config?.size?.padding ?? .medium).rawValue
        contentEdgeInsets = .init(top: padding,
                                  left: padding,
                                  bottom: padding,
                                  right: padding)
        
        configureState(with: isEnabled ? config?.normalState : config?.disabledState)
        titleLabel?.font = config?.size == .small ? .subtitle03 : .subtitle02
        
        setTitleColor(config?.normalState.textColor, for: .normal)
        setTitleColor(config?.selectedState?.textColor, for: .highlighted)
        setTitleColor(config?.disabledState?.textColor, for: .disabled)
        
        setUnderlineForAll(for: config)
    }
    
    public func animateToSelected(with duration: CGFloat) {
        displayState = .selected
        configureState(with: viewConfig?.selectedState)
    }
    
    public func animateToNormal(with duration: CGFloat) {
        displayState = .normal
        configureState(with: viewConfig?.normalState)
    }
    
    public func animateToDisabled(with duration: CGFloat) {
        displayState = .disabled
        configureState(with: viewConfig?.disabledState)
    }
    
    private func configureState(with config: NCButtonStateConfiguration?) {
        guard let config else { return }
        
        configureBorder(with: config.borderConfig)
        
        imageView?.tintColor = config.textColor
    }
    
    public func configureBorder(with border: NCBorderConfiguration?) {
        self.border = border
        drawBorder()
    }
    
    private func drawBorder() {
        layer.borderColor = border?.color?.cgColor
        layer.borderWidth = border?.width ?? 0
        layer.cornerRadius = border?.radius ?? 0
        layer.backgroundColor = border?.background?.cgColor
    }
    
    private func setUnderlineForAll(for config: C?) {
        setUnderlinedText(for: config?.normalState, state: .normal)
        setUnderlinedText(for: config?.selectedState, state: .highlighted)
        setUnderlinedText(for: config?.disabledState, state: .disabled)
    }
    
    private func setUnderlinedText(for stateConfig: NCButtonStateConfiguration?, state: UIControl.State){
        guard let underlined = stateConfig?.textUnderline, underlined  else { return }
        
        let color = stateConfig?.textColor as Any
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color,
            .underlineColor: color
        ]
        
        let attributeString = NSMutableAttributedString(
            string: title(for: state) ?? "",
            attributes: attributes
        )
        
        setAttributedTitle(attributeString, for: state)
        titleLabel?.font = viewConfig?.size == .small ? .underline02 : .underline01
    }
}
