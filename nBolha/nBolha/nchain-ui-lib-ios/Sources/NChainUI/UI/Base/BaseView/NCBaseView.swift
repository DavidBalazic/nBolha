//
//  NCBaseView.swift
//  nchain-ui
//
//  Created by Rok Črešnik on 03/08/2023.
//

import UIKit

public protocol BaseViewProtocol: UIView, ViewConfigurable, ViewModelable {}

open class BaseView<VM: ViewModel, C: Configurable>: UIView, BaseViewProtocol {
    
    public var viewModel: VM?
    public var viewConfig: C?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    open func setupSubviews() {}
    
    open func setup(with model: VM?) {
        viewModel = model
    }
    
    open func configure(with config: C?) {
        viewConfig = config
    }
}
