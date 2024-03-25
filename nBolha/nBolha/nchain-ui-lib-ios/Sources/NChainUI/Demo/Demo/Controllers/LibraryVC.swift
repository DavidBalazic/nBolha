//
//  LibraryVC.swift
//  Demo
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit
import NChainUI

class LibraryVC<V: BaseViewProtocol>: UIViewController {
    
    lazy var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = NCConstants.Margins.small.rawValue
        return view
    }()
    
    var viewModels: [V.VM] { return [] }
    var viewConfigs: [V.Config] { return [] }
    
    private lazy var spacer: UIView = {
        let view = UIView()
        return view
    }()
    
    var items: [V] {
        return stack.arrangedSubviews.compactMap { $0 as? V }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupInteractions()
    }
    
    func setupSubviews() {
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.margins)
        }
        view.setupClearMargins()
        
        for (model, config) in zip(viewModels, viewConfigs) {
            let view = V()
            view.setup(with: model)
            view.configure(with: config)
            stack.addArrangedSubview(view)
        }
        
        stack.addArrangedSubview(spacer)
        
        spacer.snp.makeConstraints { make in
            make.height.equalToSuperview().priority(.low)
        }
        view.backgroundColor = .background01
    }
    
    func setupInteractions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func viewTapped() {
        view.endEditing(true)
    }
}
