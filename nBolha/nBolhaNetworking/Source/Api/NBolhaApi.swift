//
//  nBolhaApi.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 3. 4. 24.
//

import Foundation
import nBolhaCore

public class NBolhaApi {
    public static var baseUrl: URL {
        guard let url = URL(string: "http://65.21.57.27:5080/api/") else {
            fatalError("BASE_URL not convertible to URL")
        }
        return url
    }
    
    public enum Endpoint {
        case login
        case advertisement
        
        var path: String {
            switch self {
            case .login:
                return "User/Login"
            case .advertisement:
                return "Advertisement/GetAll"
            }
        }
    }
}
