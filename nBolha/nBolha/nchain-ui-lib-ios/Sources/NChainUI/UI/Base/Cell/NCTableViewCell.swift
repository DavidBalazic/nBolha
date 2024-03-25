//
//  NCTableViewCell.swift
//  
//
//  Created by Rok Črešnik on 16/08/2023.
//

import UIKit

public class NCTableViewCell<V: ViewModel, C: Configurable>: UITableViewCell,
                                                             Identifiable,
                                                             BaseViewProtocol,
                                                             StateDisplayable {
    public var displayState: DisplayState = .normal
    public var radius: NCConstants.Radius
    
    // MARK: NCViewProtocol
    public var viewConfig: C?
    public var viewModel: V?
    
    // MARK: - Initialization
    public required init(radius: NCConstants.Radius = .zero) {
        self.radius = radius
        super.init(style: .default, reuseIdentifier: NCTableViewCell.identifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        self.radius = .zero
        super.init(coder: coder)
        setupSubviews()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.radius = .zero
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    // MARK: User interactions
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        animateTo(state: selected ? .selected : .normal, withAnimation: animated)
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        animateTo(state: highlighted ? .selected : .normal, withAnimation: animated)
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
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        viewConfig = nil
    }
}
