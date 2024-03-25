//
//  NCWrapperButtonView.swift
//  
//
//  Created by Rok Črešnik on 17/08/2023.
//

import UIKit

open class NCButtonWrapperView<T: BaseViewProtocol, C: NCButtonWrapperConfigurable>: UIControl, StateDisplayable, BaseViewProtocol {
    public var displayState: DisplayState = .normal {
        didSet { animateTo(state: displayState) }
    }
    
    public override var isEnabled: Bool {
        didSet { animateTo(state: isEnabled ? .normal : .disabled, withAnimation: true) }
    }
    
    /// This setting is for enabling and disabling the button when using UIViewRepresentable for SwiftUI
    public var isButtonEnabled = true {
        didSet {
            isUserInteractionEnabled = isButtonEnabled
            animateTo(state: isButtonEnabled ? .normal : .disabled, withAnimation: true)
        }
    }
    
    public var viewModel: T.VM?
    public var viewConfig: C?
    private var previousState = DisplayState.normal
    
    public var didTap: (() -> Void)?
    public var isTogglable = false
    public var buttonSize: ButtonSize
    private var contentView = UIView()
    var wrappedView: T = T()
    private var interactionInProgress = false
    
    // MARK: lifecycle
    public required init(size: ButtonSize = .large) {
        buttonSize = size
        super.init(frame: .zero)
        setupCustomMargins(all: size.padding)
        
        setupSubviews()
        setupActions()
    }
    
    public required init?(coder: NSCoder) {
        buttonSize = .large
        super.init(coder: coder)
        setupCustomMargins(all: .large)
        
        setupSubviews()
        setupActions()
    }
    
    public override init(frame: CGRect) {
        buttonSize = .large
        super.init(frame: frame)
        setupCustomMargins(all: .large)
        
        setupSubviews()
        setupActions()
    }
    
    public func prepareForReuse() {
        (wrappedView as? Reusable)?.prepareForReuse()
    }
    
    // MARK: Control actions
    private func setupActions() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        addTarget(self, action: #selector(touchDownRepeat), for: .touchDownRepeat)
        addTarget(self, action: #selector(touchDragInside), for: .touchDragInside)
        addTarget(self, action: #selector(touchDragOutside), for: .touchDragOutside)
        addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        addTarget(self, action: #selector(touchCancel), for: .touchCancel)
    }
    
    public func setup(with model: T.VM?) {
        wrappedView.setup(with: model)
    }

    public func configure(with config: C?) {
        viewConfig = config
        guard let state = config?.normalState as? T.Config else { return }
        
        wrappedView.configure(with: state)
        animateTo(state: .normal, withAnimation: false)
    }
    
    @objc private func touchDown() {
        guard !interactionInProgress else { return }
        interactionInProgress = true
        
        guard !isTogglable else {
            isSelected.toggle()
            animateTo(state: isSelected ? .selected : .normal)
            return
        }
        
        animateTo(state: .selected)
    }

    @objc private func touchUpInside() {
        defer {
            didTap?()
        }
        
        guard !isTogglable else {
            return
        }
        
        animateTo(state: .normal)
    }

    @objc private func touchUpOutside() {
        cancelTouch()
    }
    
    @objc private func touchDownRepeat() {}
    
    @objc private func touchDragInside() {}
    
    @objc private func touchDragOutside() {
        cancelTouch()
    }
    
    @objc private func touchDragEnter() {}
    
    @objc private func touchDragExit() {
        cancelTouch()
    }
    
    @objc private func touchCancel() {
        cancelTouch()
    }
    
    private func cancelTouch(){
        guard !isTogglable else { return }
        animateTo(state: previousState)
    }

    open func setupSubviews() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(wrappedView)
        wrappedView.snp.makeConstraints { make in
            make.edges.equalTo(snp.margins)
        }

        // so wrapped views do not interfer with touches
        contentView.isUserInteractionEnabled = false
        wrappedView.isUserInteractionEnabled = false
    }
    
    public func setup(_ closure: (T) -> Void) {
        closure(wrappedView)
    }
    
    public func animateToNormal(with duration: CGFloat) {
        configureState(with: viewConfig?.normalState)
    }
    
    public func animateToSelected(with duration: CGFloat) {
        configureState(with: viewConfig?.selectedState)
    }
    
    public func animateToDisabled(with duration: CGFloat) {
        configureState(with: viewConfig?.disabledState)
    }
    
    private func configureState(with config: C.T?) {
        guard let config = config as? T.Config else { return }
        
        UIView.transition(with: self,
                          duration: NCConstants.AnimationDuration.short.rawValue,
                          options: .transitionCrossDissolve, animations: { [weak self] in
            self?.wrappedView.configure(with: config)
        }, completion: { [weak self] _ in
            self?.interactionInProgress = false
        })
        
        guard let config = config as? SteteConfigurable,
              let border = config.border
        else { return }
        
        let hasDoubleBorder = border.outerColor != nil
        contentView.layer.borderColor = hasDoubleBorder ? border.outerColor?.cgColor : border.color?.cgColor
        contentView.layer.borderWidth = hasDoubleBorder ? border.outerWidth : border.width
        contentView.layer.cornerRadius = border.radius
        contentView.layer.backgroundColor = border.background?.cgColor
        
        let doubleBorder: BorderLayer = layer.sublayers?.first(where: { $0 is BorderLayer }) as? BorderLayer ?? BorderLayer()
        guard hasDoubleBorder else {
            doubleBorder.removeFromSuperlayer()
            return
        }
        
        doubleBorder.borderColor = border.color?.cgColor
        doubleBorder.borderWidth = border.width
        doubleBorder.cornerRadius = border.radius - border.outerWidth
        let diff = border.outerWidth
        doubleBorder.frame = layer.bounds.insetBy(dx: diff, dy: diff)
        contentView.layer.insertSublayer(doubleBorder, at: 0)
    }
}
