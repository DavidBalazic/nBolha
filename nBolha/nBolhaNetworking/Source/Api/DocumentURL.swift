//
//  DocumentURL.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 3. 4. 24.
//

import Foundation

public enum DocumentURL {
    case privacyPolicy
    case terms
    public var url: URL {
        switch self {
        case .privacyPolicy:
            return URL(string: "https://connect.complexconhk.com/privacy-policy")!

        case .terms:
            return URL(string: "https://connect.complexconhk.com/terms-of-use")!
        }
    }
}
