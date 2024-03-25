//
//  NCImageView.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit
import Lottie
import SnapKit

public final class NCImageView: BaseView<NCImageViewModel, NCBaseViewConfiguration> {
    override public var contentMode: UIView.ContentMode {
        get { return imageView.contentMode }
        set { imageView.contentMode = newValue }
    }
    
    // MARK: Lazy UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundBehavior = .pauseAndRestore
        view.isHidden = true
        return view
    }()
    
    public override var tintColor: UIColor! {
        didSet {
            imageView.tintColor = tintColor
            animationView.tintColor = tintColor
            setNeedsDisplay()
        }
    }
    
    // MARK: - View setup
    override public func setupSubviews() {
        super.setupSubviews()
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.top.equalToSuperview()
            make.height.equalTo(NCConstants.Margins.extraLarge.rawValue)
        }
        
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalTo(imageView)
        }
    }
    
    // MARK: ViewConfigurable
    public override func configure(with config: NCBaseViewConfiguration?) {
        super.configure(with: config)
        backgroundColor = config?.backgroundColor
        tintColor = config?.tintColor
    }
    
    // MARK: ViewModelable
    public override func setup(with viewModel: NCImageViewModel?) {
        super.setup(with: viewModel)
        
        switch viewModel {
        case .photo(let image):
            imageView.isHidden = false
            imageView.image = image?.withRenderingMode(.alwaysOriginal)
            imageView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.leading.top.equalToSuperview()
                make.height.equalToSuperview()
            }
            
        case .icon(let image):
            imageView.isHidden = false
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            
        case .animation(let animation, let loopMode):
            animationView.isHidden = false
            animationView.animation = animation
            animationView.loopMode = loopMode
            animationView.play()
            
        default:
            return
        }
    }
}
