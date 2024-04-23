//
//  LoginWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 3. 4. 24.
//

import Foundation

public class LoginWorker: BaseNBolhaWorker<LoginResponse> {
    var username: String
    var password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    public override func getUrl() -> String {
        return super.getUrl() + NBolhaApi.Endpoint.login.path
    }

    public override func getParameters() -> [String : Any] {
        return [
            "username": username,
            "password": password,
        ]
    }

    public override func getMethod() -> HTTPMethod {
        return .post
    }
}
