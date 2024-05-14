//
//  Advertisement.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 8. 4. 24.
//

import Foundation

public struct Advertisement: Codable, Hashable {
    public let advertisementId: Int?
    public let title: String?
    public let description: String?
    public let price: Double?
    public let created_At: String?
    public let images: [ImageObject]?
    public let address: Int?
    public let category: Int?
    public let condition: Int?
    public var isInWishlist: Bool?
}

public struct ImageObject: Codable, Hashable {
    let imageAddress: String
}
