//
//  NCPinInputView.swift
//  
//
//  Created by Rok Črešnik on 18/08/2023.
//

import UIKit

public final class NCPinInputView: BaseView<NCPinInputViewModel, NCInputViewConfiguration>, NCTextFieldDelegate, StateDisplayable {
    public var displayState: DisplayState = .normal {
        didSet { animateTo(state: displayState) }
    }
    
    public var didFinish: ((String?) -> Void)?
    public var didUpdate: ((String?) -> Void)?
    
    private let pinLength: Int
    private var labelLeading: CGFloat?
    
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = NCConstants.Margins.small.rawValue
        return view
    }()
    
    private lazy var pinStack: UIStackView = {
        let view = UIStackView()
        view.spacing = NCConstants.Margins.small.rawValue
        view.distribution = .fillEqually
        return view
    }()
    
    private var textFields: [NCTextField] {
        return pinStack.arrangedSubviews.compactMap { ($0 as? BorderView<NCTextField>)?.contentView }
    }
    
    private var value: String {
        textFields.compactMap { $0.text }.joined()
    }
    
    private lazy var label: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var labelWithLeading: UIView = {
        let view = UIView()
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(labelLeading ?? 0)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return view
    }()
    
    required public init(pinLength: Int = 6, labelLeadingMargin: CGFloat? = nil) {
        self.pinLength = pinLength
        self.labelLeading = labelLeadingMargin
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required public init?(coder: NSCoder) {
        pinLength = 6
        super.init(coder: coder)
        setupSubviews()
    }
    
    public override init(frame: CGRect) {
        pinLength = 6
        super.init(frame: frame)
        setupSubviews()
    }
    
    public override func becomeFirstResponder() -> Bool {
        return textFields.first?.becomeFirstResponder() ?? false
    }
    
    public override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(snp.margins)
        }
        setupClearMargins()
        
        stack.addArrangedSubview(pinStack)
        stack.addArrangedSubview(labelWithLeading)
        
        guard pinStack.arrangedSubviews.isEmpty == true else { return }
        
        pinLength.times {
            let input = BorderView<NCTextField>()
            input.setupClearMargins()
            input.contentView.myDelegate = self
            input.contentView.textAlignment = .center
            input.contentView.isSecureTextEntry = true
            input.contentView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            let tap = UITapGestureRecognizer(target: self, action: #selector(textFieldSelected(_:)))
            input.contentView.addGestureRecognizer(tap)
            pinStack.addArrangedSubview(input)
            input.snp.makeConstraints { make in
                make.width.equalTo(input.snp.height)
            }
        }
    }
    
    public override func configure(with config: NCInputViewConfiguration?) {
        super.configure(with: config)
        displayState = .normal
        
        textFields.forEach { ($0.superview as? BorderView<NCTextField>)?.setErrorColor(config?.errorState?.errorViewConfiguration?.backgroundColor) }
        textFields.forEach { ($0.superview as? BorderView<NCTextField>)?.configure(with: viewConfig?.normalState.borderConfiguration) }
        guard let config = config?.normalState.textConfiguration else { return }
        textFields.forEach { $0.configure(with: config) }
    }
    
    public override func setup(with model: NCPinInputViewModel?) {
        super.setup(with: model)
        label.text = model?.status
        displayState = .normal
    }
    
    public func animateToNormal(with duration: CGFloat) {
        label.text = viewModel?.status
        label.configure(with: .init(textColor: viewConfig?.normalState.tint))
        textFields.forEach { ($0.superview as? BorderView<NCTextField>)?.displayState = .normal }
    }
    
    public func animateToError(with duration: CGFloat) {
        label.text = viewModel?.error
        label.configure(with: viewConfig?.errorState?.hintConfiguration)
        textFields.forEach { ($0.superview as? BorderView<NCTextField>)?.displayState = .error }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidDelete(_ textField: NCTextField) {
        defer {
            updateSecureTextEntries()
        }
        
        guard let index = textFields.firstIndex(of: textField),
              index > 0
        else {
            return
        }
        let next = textFields[index - 1]
        next.becomeFirstResponder()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        defer {
            updateSecureTextEntries()
        }
        
        guard let input = textField.text,
              let textField = textField as? NCTextField,
              let index = textFields.firstIndex(of: textField)
        else {
            textField.resignFirstResponder()
            didFinish?(value)
            return
        }
        
        switch input.count {
        case 0:
            // We are deleting
            if index > 0 {
                let previous = textFields[index - 1]
                previous.becomeFirstResponder()
            }

        default:
            if input.count > 1 {
                for tf in textFields {
                    tf.text = ""
                }

                for (i, char) in input.enumerated() {
                    if i < textFields.count {
                        textFields[i].text = String(char)
                    }
                }

                if textFields.filter { $0.text?.isEmpty == false }.count >= pinLength {
                    textField.resignFirstResponder()
                    didFinish?(value)
                } else {
                    textFields.last(where: { $0.text?.isEmpty == true })?
                        .becomeFirstResponder()
                }
            } else {
                // We are entering
                guard index < pinLength - 1 else {
                    textField.text = input.prefix(1).description
                    textField.resignFirstResponder()
                    didFinish?(value)
                    return
                }
                let next = textFields[index + 1]
                next.becomeFirstResponder()
            }
        }
        
    }
    
    @objc private func textFieldSelected(_ gesture: UITapGestureRecognizer) {
        guard let textField = gesture.view as? NCTextField else { return }
        
        guard let selected = textFields.firstIndex(of: textField) else {
            textFields.forEach { $0.isSecureTextEntry = true }
            return
        }
        
        defer {
            updateSecureTextEntries()
        }
        
        let length = value.count
        guard length >= selected else {
            let tf = textFields[length == 0 ? 0 : length]
            tf.becomeFirstResponder()
            
            return
        }
        textField.becomeFirstResponder()
    }
    
    // MARK: - Other helpers
    private func updateSecureTextEntries() {
        defer {
            didUpdate?(value)
        }
        
        guard let selected = textFields.firstIndex(where: { $0.isFirstResponder }) else {
            textFields.forEach {
                $0.isSecureTextEntry = true
                ($0.superview as? BorderView<NCTextField>)?.configure(with: viewConfig?.normalState.borderConfiguration)
            }
            return
        }
        
        for (index, tf) in textFields.enumerated() {
            tf.isSecureTextEntry = selected != (index + 1)
            
            if index >= selected {
                tf.text = nil
            }
            
            let config: NCBorderConfiguration?
            switch tf.isFirstResponder {
            case true:
                config = viewConfig?.selectedState?.borderConfiguration
            default:
                config = viewConfig?.normalState.borderConfiguration
            }
            (tf.superview as? BorderView<NCTextField>)?.configure(with: config)
        }
        
        displayState = .normal
    }
}
