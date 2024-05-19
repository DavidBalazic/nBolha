//
//  FilterAdvertisementWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 18. 5. 24.
//

import Foundation

public class FilterAdvertisementWorker: BaseNBolhaWorker<[Advertisement]> {
    var category: String?
    var keyword: String?
    var orderBy: String?
    var conditions: [String]?

    public init(
        category: String? = nil, 
        keyword: String? = nil,
        orderBy: String? = nil,
        conditions: [String]? = nil
    ) {
        self.category = category
        self.keyword = keyword
        self.orderBy = orderBy
        self.conditions = conditions
    }
    
    public override func getUrl() -> String {
        var url = super.getUrl() + NBolhaApi.Endpoint.filterAdvertisement.path
        url += buildQueryString()
        return url
    }
    
    private func buildQueryString() -> String {
        var queryItems = [URLQueryItem]()
        
        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        if let keyword = keyword {
            queryItems.append(URLQueryItem(name: "keyword", value: keyword))
        }
        if let orderBy = orderBy {
            queryItems.append(URLQueryItem(name: "orderBy", value: orderBy))
        }
        if let conditions = conditions {
            for condition in conditions {
                queryItems.append(URLQueryItem(name: "conditions", value: condition))
            }
        }
        
        var components = URLComponents()
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components.query?.isEmpty == false ? "?" + (components.query ?? "") : ""
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
