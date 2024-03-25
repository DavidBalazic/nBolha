//
//  NCWrapperTableViewCell.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public class NCWrapperTableViewCell<V: BaseViewProtocol>: NCTableViewCell<V.VM, V.Config>,
                                                        Wrappable {
    
    // MARK: Wrappable
    public lazy var wrappedView = V()
    
    // MARK: Overrides
    public override func setupSubviews() {
        super.setupSubviews()
        backgroundColor = .clear
        contentView.addSubview(wrappedView)
        selectionStyle = .none
        
        wrappedView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.margins)
        }
    }
    
    /// Returns the wrapped view for further customizations
    public func configureSubviews(configure: (V) -> Void) {
        configure(wrappedView)
    }
    
    public override func configure(with config: V.Config?) {
        super.configure(with: config)
        wrappedView.configure(with: config)
    }
    
    public override func setup(with viewModel: V.VM?) {
        super.setup(with: viewModel)
        wrappedView.setup(with: viewModel)
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        guard let view = wrappedView as? StateDisplayable else {
            super.setSelected(selected, animated: animated)
            return
        }
        let state: DisplayState = selected ? .selected : .normal
        view.animateTo(state: state, withAnimation: true)
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        guard let view = wrappedView as? StateDisplayable else {
            super.setHighlighted(highlighted, animated: animated)
            return
        }
        let state: DisplayState = highlighted ? .selected : .normal
        view.animateTo(state: state, withAnimation: true)
    }
    
    public override func prepareForReuse() {
        defer {
            super.prepareForReuse()
        }
        
        guard let reusable = wrappedView as? Reusable else { return }
        reusable.prepareForReuse()
    }
}
