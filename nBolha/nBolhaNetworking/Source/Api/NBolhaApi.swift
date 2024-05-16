//
//  nBolhaApi.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 3. 4. 24.
//

import Foundation

public class NBolhaApi {
    public static var baseUrl: URL {
        guard let url = URL(string: "http://65.21.57.27:5080") else {
            fatalError("BASE_URL not convertible to URL")
        }
        return url
    }
    
    public enum Endpoint {
        case login
        case advertisements
        case advertisementRecentlyAdded
        case advertisementRecentlyViewed
        case advertisement(id: Int)
        case getWishlist
        case addToWishlist(id: Int)
        case deleteWishlist(id: Int)
        
        var path: String {
            switch self {
            case .login:
                return "/api/User/Login"
            case .advertisements:
                return "/api/Advertisement/GetAll"
            case .advertisementRecentlyAdded:
                return "/api/Advertisement/RecentlyAdded"
            case .advertisementRecentlyViewed:
                return "/api/Advertisement/RecentlyViewed"
            case .advertisement(id: let id):
                return "/api/Advertisement/\(id)"
            case .getWishlist:
                return "/api/Wishlist/GetWishlist"
            case .addToWishlist(id: let id):
                return "/api/Wishlist/\(id)"
            case .deleteWishlist(id: let id):
                return "/api/Wishlist/\(id)"
            }
        }
    }
}
