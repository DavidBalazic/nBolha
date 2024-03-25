//
//  File.swift
//  
//
//  Created by Rok Črešnik on 17/08/2023.
//

import UIKit

public final class AccessoryTitleButton: NCButtonWrapperView<AccessoryTitleView, AccessoryTitleButtonConfiguration> {}

public protocol SteteConfigurable: Configurable {
    var border: NCBorderConfiguration? { get set }
}

public final class AccessoryTitleView: BaseView<AccessoryTitleViewModel, AccessoryTitleViewConfiguration> {
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.spacing = NCConstants.Margins.small.rawValue
        return view
    }()
    
    private lazy var leadingSpacer = UIView()
    
    private lazy var leading: NCImageView = {
        let view = NCImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var trailing: NCImageView = {
        let view = NCImageView()
        return view
    }()
    
    private lazy var trailingSpacer = UIView()
    
    public var axis: NSLayoutConstraint.Axis {
        set { stack.axis = newValue }
        get { return stack.axis }
    }
    
    public override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(snp.margins)
        }
        setupClearMargins()
        
        stack.addArrangedSubview(leadingSpacer)
        stack.addArrangedSubview(leading)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(trailing)
        
        stack.addArrangedSubview(trailingSpacer)
        leadingSpacer.snp.makeConstraints { make in
            make.width.equalToSuperview().priority(.low)
            make.height.equalToSuperview().priority(.low)
        }
        
        trailingSpacer.snp.makeConstraints { make in
            make.width.equalToSuperview().priority(.low)
            make.height.equalToSuperview().priority(.low)
            make.width.equalTo(leadingSpacer)
        }
    }
    
    public override func setup(with model: AccessoryTitleViewModel?) {
        super.setup(with: model)
        leading.setup(with: model?.leading)
        leading.isHidden = model?.leading == nil
        
        titleLabel.setup(with: model?.title)
        titleLabel.isHidden = model?.title == nil
        
        trailing.setup(with: model?.trailing)
        trailing.isHidden = model?.trailing == nil
        
        // if 2 elements are hidden, hide spacers
        let hiddenCount = leading.isHidden.toInt() + trailing.isHidden.toInt() + titleLabel.isHidden.toInt()
        leadingSpacer.isHidden = hiddenCount == 2
        trailingSpacer.isHidden = hiddenCount == 2
    }
    
    public override func configure(with config: AccessoryTitleViewConfiguration?) {
        super.configure(with: config)
        
        leading.configure(with: config?.accessory)
        titleLabel.configure(with: config?.title)
        trailing.configure(with: config?.accessory)
    }
}
