//
//  User2.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 17. 5. 24.
//

import Foundation

public struct User: Decodable {
    public let username: String?
    public let name: String?
    public let imageAddress: String?
    public let location: String?
    public var fullImageURL: URL? {
        guard let imageAddress = imageAddress else { return nil }
        return URL(string: "\(NBolhaApi.baseUrl.absoluteString)\(imageAddress)")
    }
}
