//
//  BorderView.swift
//  
//
//  Created by Rok Črešnik on 10/08/2023.
//

import UIKit

public class BorderView<V: UIView>: UIView, StateDisplayable {
    public var contentView: V
    public var displayState: DisplayState = .normal {
        didSet { animateTo(state: displayState) }
    }
    
    private lazy var errorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .inverseError
        return view
    }()
    
    private var border: NCBorderConfiguration = .init()
    
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
        drawBorder()
    }
    
    public func setupSubviews() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(snp.leadingMargin)
            make.top.equalTo(snp.topMargin)
        }
        
        let margin = NCConstants.Margins.small.rawValue
        layoutMargins = .init(top: margin, left: margin, bottom: margin, right: margin)
        clipsToBounds = true
        
        addSubview(errorLine)
        errorLine.snp.makeConstraints { make in
            make.centerX.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(NCConstants.Margins.extraSmall.rawValue)
        }
        errorLine.isHidden = true
    }
    
    public func configure(with border: NCBorderConfiguration?) {
        guard let border else { return }
        self.border = border
        drawBorder()
    }
    
    public func setErrorColor(_ color: UIColor?) {
        if let color {
            errorLine.backgroundColor = color
        }
    }
    
    private func drawBorder() {
        let hasDoubleBorder = border.outerColor != nil
        layer.borderColor = hasDoubleBorder ? border.outerColor?.cgColor : border.color?.cgColor
        layer.borderWidth = hasDoubleBorder ? border.outerWidth : border.width
        layer.cornerRadius = border.radius
        layer.backgroundColor = border.background?.cgColor
        layer.backgroundColor = hasDoubleBorder ? UIColor.clear.cgColor : border.background?.cgColor
        
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
        layer.insertSublayer(doubleBorder, at: 0)
    }
    
    public func animateToNormal(with duration: CGFloat) {
        Self.animate(withDuration: duration) { [weak self] in
            self?.errorLine.isHidden = true
        }
    }
    
    public func animateToError(with duration: CGFloat) {
        Self.animate(withDuration: duration) { [weak self] in
            self?.errorLine.isHidden = false
        }
    }
}

class BorderLayer: CALayer {}
