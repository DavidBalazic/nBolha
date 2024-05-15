//
//  PostAdvertisementWorkerž.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 14. 5. 24.
//

import Foundation
import UIKit

public class PostAdvertisementWorker: BaseNBolhaWorker<String> {
    var title: String
    var description: String
    var price: Double
    var address: String
    var category: String
    var condition: String
    var images: [UIImage]

    public init(
        title: String,
        description: String,
        price: Double,
        address: String,
        category: String,
        condition: String,
        images: [UIImage]
    ) {
        self.title = title
        self.description = description
        self.price = price
        self.address = address
        self.category = category
        self.condition = condition
        self.images = images
    }
    
    public override func getUrl() -> String {
        let baseUrl = super.getUrl()
        let endpointPath = NBolhaApi.Endpoint.postAdvertisement.path
        let queryString = "Title=\(title)&Description=\(description)&Price=\(price)&Address=\(address)&Category=\(category)&Condition=\(condition)"
        return "\(baseUrl)\(endpointPath)?\(queryString)"
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
    
    public override func execute(completion: Completion?) {
        self.completion = completion
        Task {
            var multipart: [MultiPart] = []
            
            for image in images {
                //TODO: fix the compression
                guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                    print("Error compressing image")
                    return
                }
                
                multipart.append(MultipartMedia(
                    with: imageData,
                    fileName: "image",
                    forKey: "Images",
                    mimeType: .jpeg,
                    mimeFileFormat: .jpeg
                ))
            }
            executeMultipartRequest(data: multipart)
        }
    }
}
