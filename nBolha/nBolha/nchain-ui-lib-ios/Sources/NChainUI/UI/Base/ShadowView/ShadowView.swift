//
//  ShadowView.swift
//  
//
//  Created by Rok Črešnik on 10/08/2023.
//

import UIKit

public class ShadowView<V: UIView>: UIView {
    public var contentView: V
    public var shadow: ShadowConfiguration = .init()
    
    public required init(contentView: V) {
        self.contentView = contentView
        super.init(frame: .zero)
        setupSubviews()
    }
    
    override public init(frame: CGRect) {
        contentView = V()
        super.init(frame: frame)
        setupSubviews()
    }

    required public init?(coder: NSCoder) {
        contentView = V()
        super.init(coder: coder)
        setupSubviews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: .allCorners,
                                cornerRadii: .init(width: shadow.radius, height: shadow.radius))
        
        layer.shadowPath = path.cgPath
        layer.shadowColor = shadow.color.cgColor
        layer.shadowOpacity = shadow.opacity
        layer.shadowOffset = shadow.offset
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func setupSubviews() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
            make.top.equalTo(snp.topMargin)
            make.bottom.equalTo(snp.bottomMargin).priority(.low)
        }
        
        let margin = 0.0
        layoutMargins = .init(top: margin, left: margin, bottom: margin, right: margin)
    }
}
