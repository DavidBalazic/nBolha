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
    
    public func execute() async throws -> T? {
        return try await withCheckedThrowingContinuation { continuation in
            execute { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: result)
                }
            }
        }
    }
    
    public override func processResponse(response: HTTPResponse) {
        if response.statusCode == 401 {
            handleTokenExpiredError()
        }
       guard let data = response.data, response.error == nil else { return }
       guard let payload = T.parse(from: data, type: T.self) else { return }
    
       result = payload
    }
    
    private func handleTokenExpiredError() {
        NotificationCenter.default.post(name: .tokenExpiredNotification, object: nil)
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
