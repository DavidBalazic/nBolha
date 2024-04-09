//
//  LoginWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 3. 4. 24.
//

import Foundation

public class BaseNBolhaWorker<T: Decodable>: APICallWorker {
    public typealias Completion = (T?, NetworkingError?) -> Void
    
    var completion: Completion?
    var result: T?
    
    public func execute(completion: Completion?) {
        self.completion = completion
        execute()
    }
    
    public override func processResponse(response: HTTPResponse) {
       guard let data = response.data, response.error == nil else { return }
       //guard let payload = T.parse(from: data, type: T.self) else { return }
        if let stringResponse = String(data: data, encoding: .utf8) {
               result = stringResponse as? T
           } else {
               print("Failed to decode plain text response")
           }
    
       //result = payload
    }
    
    public override func getUrl() -> String {
        return NBolhaApi.baseUrl.absoluteString
    }
    
    public override func getHeaders() -> [String : String] {
        return [
            "accept": "text/plain",
            "Content-Type": "application/json"
        ]
    }
    
    public override func apiCallDidFinish(response: HTTPResponse) {
        completion?(result, response.error)
    }
}
