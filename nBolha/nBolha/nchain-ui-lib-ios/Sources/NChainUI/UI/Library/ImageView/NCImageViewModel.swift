//
//  NCImageViewModel.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import UIKit
import Lottie

extension LottieAnimation: Hashable {
    public static func == (lhs: LottieAnimation, rhs: LottieAnimation) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

public enum NCImageViewModel: ViewModel {
    case animation(LottieAnimation?, LottieLoopMode)
    /// icons are displayed with template rendering mode
    case icon(UIImage?)
    /// photos are displayed with original rendering mode
    case photo(UIImage?)
}
