//
//  ImagesVC.swift
//  Demo
//
//  Created by Rok Črešnik on 18/09/2023.
//

import UIKit
import NChainUI

class ImagesVC: LibraryVC<NCImageView> {
    
    override var viewModels: [NCImageViewModel] {
        return [
            .icon(.icnCheckbox),
            .animation(NCAnimation.warning.animation, .loop),
            .photo(.icnCheckbox)
        ]
    }
    
    override var viewConfigs: [NCBaseViewConfiguration]  {
        return [
            .init(tintColor: .red),
            .init(),
            .init(tintColor: .red)
        ]
    }
}
