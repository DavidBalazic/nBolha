//
//  AddToWishlistWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 26. 4. 24.
//

import Foundation

public class AddToWishlistWorker: BaseNBolhaWorker<String> {
    var advertisementId: Int
    
    public init(
        advertisementId: Int
    ) {
        self.advertisementId = advertisementId
    }
    
    public override func getUrl() -> String {
        return super.getUrl() + NBolhaApi.Endpoint.addToWishlist(id: advertisementId).path
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
        return .post
    }
}
