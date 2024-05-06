//
//  AdvertisementWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 8. 4. 24.
//

import Foundation

public class AdvertisementWorker: BaseNBolhaWorker<[Advertisement]> {

    public override func getUrl() -> String {
        return super.getUrl() + NBolhaApi.Endpoint.advertisements.path
    }

    public override func getHeaders() -> [String : String] {
        return [:]
    }
    
    public override func getMethod() -> HTTPMethod {
        return .get
    }
}
