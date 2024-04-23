//
//  LoginResponse.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 23. 4. 24.
//

import Foundation

public struct LoginResponse: Decodable {
    public let username: String
    public let token: String
}
