//
//  AdvertisementViewedWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 23. 4. 24.
//

import Foundation

public class AdvertisementViewedWorker: BaseNBolhaWorker<[Advertisement]> {
    private let advertisementId: Int
    
    public init(
        advertisementId: Int
    ) {
        self.advertisementId = advertisementId
    }

    public override func getUrl() -> String {
        return super.getUrl() + NBolhaApi.Endpoint.advertisement(id: advertisementId).path
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
