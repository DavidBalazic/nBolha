//
//  UploadProfilePictureWorker.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 20. 5. 24.
//

import Foundation
import UIKit

public class UploadProfilePictureWorker: BaseNBolhaWorker<String> {
    var image: UIImage

    public init(
        image: UIImage
    ) {
        self.image = image
    }

    public override func getUrl() -> String {
        return super.getUrl() + NBolhaApi.Endpoint.uploadProfilePicture.path
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
            
            //TODO: fix the compression
            guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                print("Error compressing image")
                return
            }
            
            multipart.append(MultipartMedia(
                with: imageData,
                fileName: "image",
                forKey: "file",
                mimeType: .jpeg,
                mimeFileFormat: .jpeg
            ))
            
            executeMultipartRequest(data: multipart)
        }
    }
}
