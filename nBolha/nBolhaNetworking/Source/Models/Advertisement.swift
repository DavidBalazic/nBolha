//
//  Advertisement.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 8. 4. 24.
//

import Foundation

public struct Advertisement: Codable, Hashable {
    public let id: Int?
    public let title: String?
    public let description: String?
    public let price: Double?
    public let condition: String?
}
