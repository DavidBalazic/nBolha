//
//  NCBaseInputView.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit
import SnapKit

open class NCBaseInputView<VM: NCInputViewModelable, C: NCInputViewConfigurable>: BaseView<VM, C>, UITextFieldDelegate, StateDisplayable {
    
    public var displayState: DisplayState = .normal
    public var valueChanged: ((UITextField) -> Void)?
    public var beganEditing: ((UITextField) -> Void)?
    public var finishedEditing: ((UITextField) -> Void)?
    public var shouldReturn: ((UITextField) -> Bool)?

    public var onResize: (() -> Void)?
    
    public var didTapTrailingView: ((NCImageView?) -> Void)?
    public var didTapLeadingView: ((NCImageView?) -> Void)?
    
    public var errorText: String? {
        set {
            viewModel?.error = newValue
        }
        
        get {
            return viewModel?.error
        }
    }
    
    public var isSecureTextEntry: Bool {
        set { textField.isSecureTextEntry = newValue }
        get { return textField.isSecureTextEntry }
    }
    
    private lazy var mainStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = NCConstants.Margins.small.rawValue
        return view
    }()
    
    private lazy var contentStack: BorderView<UIStackView> = {
        let view = BorderView<UIStackView>()
        view.contentView.spacing = NCConstants.Margins.small.rawValue
        return view
    }()
    
    private lazy var leadingView: NCImageView = {
        let view = NCImageView()
        return view
    }()
    
    private lazy var middleStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    private lazy var trailingView: NCImageView = {
        let view = NCImageView()
        return view
    }()
    
    private lazy var errorLineView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        return view
    }()
    
    private lazy var statusContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    public var delegate: UITextFieldDelegate? {
        get { textField.delegate }
        set { textField.delegate = newValue }
    }
    
    public override var isUserInteractionEnabled: Bool {
        didSet {
            animateTo(state: isUserInteractionEnabled ? .normal : .disabled, withAnimation: true)
        }
    }
    
    override public func setupSubviews() {
        super.setupSubviews()
        textField.delegate = self
        
        setupClearMargins()
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
            make.top.equalTo(snp.topMargin)
            make.bottom.equalTo(snp.bottomMargin)
        }
        
        mainStack.addArrangedSubview(contentStack)
        contentStack.setupCustomMargins(all: .extraSmall)
        
        contentStack.snp.makeConstraints { make in
            make.height.equalTo(NCConstants.Margins.giant.rawValue)
        }
        
        statusContentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(NCConstants.Margins.medium.rawValue)
        }
        
        mainStack.addArrangedSubview(statusContentView)
        statusContentView.snp.makeConstraints { make in
            make.height.equalTo(NCConstants.Margins.extraLarge.rawValue)
        }
        
        contentStack.contentView.addArrangedSubview(leadingView)
        leadingView.snp.makeConstraints { make in
            make.width.equalTo(NCConstants.Margins.extraLarge.rawValue)
        }
        contentStack.contentView.addArrangedSubview(middleStack)
        contentStack.contentView.addArrangedSubview(trailingView)
        trailingView.snp.makeConstraints { make in
            make.width.equalTo(NCConstants.Margins.extraLarge.rawValue)
        }
        
        contentStack.bringSubviewToFront(errorLineView)
        errorLineView.isHidden = true
        
        middleStack.addArrangedSubview(titleLabel)
        middleStack.addArrangedSubview(textField)
        
        contentStack.addSubview(errorLineView)
        errorLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(NCConstants.Margins.extraSmall.rawValue)
        }
        errorLineView.backgroundColor = .errorDefault
        errorLineView.isHidden = true
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(leadingViewTapped))
        leadingView.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(trailingViewTapped))
        trailingView.addGestureRecognizer(tap)
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    public override func becomeFirstResponder() -> Bool {
        animateTo(state: .selected)
        return textField.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        animateTo(state: .normal)
        return textField.resignFirstResponder()
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return resignFirstResponder()
    }

    @objc private func viewTapped() {
        animateTo(state: .selected, withAnimation: true)
    }
    
    override public func setup(with model: VM?) {
        super.setup(with: model)
        
        titleLabel.text = model?.title
        textField.text = model?.value
        textField.isHidden = model?.value?.isEmpty != false && displayState != .selected
        textField.placeholder = model?.placeholder
        statusLabel.text = model?.hint
        statusLabel.sizeToFit()
        displayStatusContent()
        
        if let leading = model?.leading {
            leadingView.setup(with: leading)
        }
        leadingView.isHidden = model?.leading == nil
        
        if let trailing = model?.trailing {
            trailingView.setup(with: trailing)
        }
        trailingView.isHidden = model?.trailing == nil
    }
    
    override public func configure(with config: C?) {
        super.configure(with: config)
        animateTo(state: .normal)
    }
    
    public func animateToSelected(with duration: CGFloat) {
        displayState = .selected
        textField.becomeFirstResponder()
        contentStack.setupCustomMargins(vertical: .extraSmall, horizontal: .medium)
        textField.isHidden = false
        statusLabel.text = viewModel?.hint
        displayStatusContent()
        errorLineView.isHidden = true
        configureState(with: viewConfig?.selectedState)
        
        Self.animate(withDuration: duration) { [weak self] in
            self?.onResize?()
        }
    }
    
    public func animateToNormal(with duration: CGFloat) {
        displayState = .normal
        textField.isHidden = textField.text?.isEmpty == true
        if textField.text?.isEmpty == true {
            contentStack.setupCustomMargins(all: .medium)
        }
        configureState(with: viewConfig?.normalState)
        statusLabel.text = viewModel?.hint
        displayStatusContent()
        Self.animate(withDuration: duration) { [weak self] in
            self?.onResize?()
        }
    }
    
    public func animateToError(with duration: CGFloat) {
        displayState = .error
        textField.isHidden = textField.text?.isEmpty == true
        errorLineView.isHidden = false
        statusLabel.text = viewModel?.error
        displayStatusContent()
        configureState(with: viewConfig?.errorState)
        
        Self.animate(withDuration: duration) { [weak self] in
            self?.onResize?()
        }
    }
    
    public func animateToDisabled(with duration: CGFloat) {
        displayState = .disabled
        configureState(with: viewConfig?.disabledState)
        displayStatusContent()
        Self.animate(withDuration: duration) { [weak self] in
            self?.onResize?()
        }
    }
    
    private func displayStatusContent() {
        switch displayState {
        case .normal:
            statusContentView.isHidden = viewModel?.hint == nil && errorLineView.isHidden
        case .selected:
            statusContentView.isHidden = viewModel?.hint == nil
        case .disabled:
            statusContentView.isHidden = true
        case .error:
            statusContentView.isHidden = viewModel?.error == nil
        }
    }
    
    private func configureState(with config: NCInputViewStateConfiguration?) {
        guard let config else { return }
        
        let titleFont = (displayState != .selected && textField.text?.isEmpty == true) ? config.textConfiguration?.font : config.titleConfiguration?.font
        if var config = config.titleConfiguration {
            config.font = titleFont ?? config.font
            titleLabel.configure(with: config)
        }
        
        if let config = config.hintConfiguration {
            statusLabel.configure(with: config)
        }
        
        if let config = config.textConfiguration {
            textField.configure(with: config.withSecureTextEntry(isSecureTextEntry))
        }
        
        if let config = config.placeholderConfiguration,
           let placeholder = textField.placeholder {
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.foregroundColor: config.textColor ?? .black,
                NSAttributedString.Key.font : config.font
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
        
        if let config = config.leadingConfiguration {
            leadingView.configure(with: config)
        }
        
        if let config = config.trailingConfiguration {
            trailingView.configure(with: config)
        }
        
        if let config = config.borderConfiguration {
            contentStack.configure(with: config)
        }
        
        if let config = config.errorViewConfiguration {
            errorLineView.tintColor = config.tintColor
            errorLineView.backgroundColor = config.backgroundColor
        }
        
        if let config = config.marginsConfiguration {
            contentStack.setupCustomMargins(vertical: config.vertical, horizontal: config.horizontal)
        }
    }
    
    public var value: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    @objc private func startEditing() {
        textField.becomeFirstResponder()

        animateTo(state: .selected, withAnimation: true)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTo(state: .selected, withAnimation: true)
        
        beganEditing?(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        finishedEditing?(textField)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return shouldReturn?(textField) ?? true
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        valueChanged?(textField)
    }
    
    @objc private func leadingViewTapped() {
        didTapLeadingView?(leadingView)
    }
    
    @objc private func trailingViewTapped() {
        didTapTrailingView?(trailingView)
    }
}
