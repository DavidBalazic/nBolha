//
//  nBolhaApi.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 3. 4. 24.
//

import Foundation

public class NBolhaApi {
    public static var baseUrl: URL {
        guard let url = URL(string: "http://65.21.57.27:5080/api/") else {
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
        case addToWishlist
        case deleteWishlist(id: Int)
        case postAdvertisement
        
        var path: String {
            switch self {
            case .login:
                return "User/Login"
            case .advertisements:
                return "Advertisement/GetAll"
            case .advertisementRecentlyAdded:
                return "Advertisement/Recent"
            case .advertisementRecentlyViewed:
                return "Advertisement/RecentViewed"
            case .advertisement(id: let id):
                return "Advertisement/\(id)"
            case .getWishlist:
                return "Wishlist/GetWishlist"
            case .addToWishlist:
                return "Wishlist/AddToWishlist"
            case .deleteWishlist(id: let id):
                return "Wishlist/\(id)"
            case .postAdvertisement:
                return "Advertisement/PostAdvertisement"
            }
        }
    }
}
