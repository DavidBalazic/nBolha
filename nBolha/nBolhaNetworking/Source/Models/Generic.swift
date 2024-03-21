//
//  EQNetworking
//  Copyright © 2022 Equaleyes Ltd. All rights reserved.
//

import Foundation

public protocol ModelResponse: Codable {
}

public protocol Model {}

extension Array: Model {}

// TODO: should be a protocol (look at blare's implementation)
open class ModelMapper<T: ModelResponse, U: Model> {
    required public init() {}
    
    open func getModel(from response: T) -> U? {
        return nil
    }
}

// TODO: does not belong here.. its already part of CLEANerSwift
enum GenericModels {
    enum Error {
        struct ActionResponse {
            let error: NetworkingError
        }
        struct ResponseDisplay {
            let error: String
        }
    }
}

protocol ErrorActionResponse {
    func presentError(actionResponse: GenericModels.Error.ActionResponse)
}

protocol ErrorResponseDisplay {
    func displayError(responseDisplay: GenericModels.Error.ResponseDisplay)
}
