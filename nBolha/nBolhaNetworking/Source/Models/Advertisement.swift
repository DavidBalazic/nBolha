//
//  Advertisement.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 8. 4. 24.
//

import Foundation

public struct Advertisement: Codable, Hashable {
    public let advertisement_id: Int?
    public let title: String?
    public let description: String?
    public let price: Double?
    public let condition: String?
    public let created_At: Date?
    public let user_id_FK: Int?
    public let category_id_FK: Int?
    public let address: Int?
}
