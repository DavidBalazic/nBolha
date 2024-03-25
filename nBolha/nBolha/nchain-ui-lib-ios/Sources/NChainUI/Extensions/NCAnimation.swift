//
//  NCAnimation.swift
//  
//
//  Created by Rok Črešnik on 09/08/2023.
//

import Lottie

extension LottieLoopMode: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .repeat(let value): hasher.combine(value)
        case .repeatBackwards(let value): hasher.combine(value)
        default: break
        }
    }
}

public enum NCAnimation: Hashable {
    case warning
    
    public var animation: LottieAnimation? {
        let name: String
        switch self {
        case .warning: name = "animationWarning"
        }
        return LottieAnimation.named(name, bundle: .nchainUI)
    }
}
