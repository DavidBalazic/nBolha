//
//  GetUserInfoWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 17. 5. 24.
//

import Foundation

public class GetUserInfoWorker: BaseNBolhaWorker<User> {
    
    public override func getUrl() -> String {
        return super.getUrl() + NBolhaApi.Endpoint.userInfo.path
    }

    public override func getHeaders() -> [String : String] {
        let sessionTokenId = "sessionTokenID"
        let keychainManager = KeyChainManager(service: Constants.keychainServiceIdentifier)
        guard let token = keychainManager.get(forKey: sessionTokenId) else {
            return [:]
        }
        return ["Authorization" : "bearer \(token)"]
    }
    
    public override func getMethod() -> HTTPMethod {
        return .get
    }
}
