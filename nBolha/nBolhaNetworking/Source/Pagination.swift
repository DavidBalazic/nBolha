//
//  EQNetworking
//  Copyright © 2022 Equaleyes Ltd. All rights reserved.
//

import Foundation

public class Pagination {
    private var currentPage = 0
    private var isIdle = true
    
    public func firstPageLoad() {
        currentPage = 0
        isIdle = false
    }
    
    public func nextPageLoad() {
        isIdle = false
    }
    
    private func successLoadingPage(objectCount: Int) {
        isIdle = true
        currentPage += 1
    }
    
    private func failureLoadingPage() {
        isIdle = true
    }
    
    public func getPagingParameters() -> [String: Any] {
        return [
            "page": currentPage
        ]
    }
    
    public func shouldLoadNextPage() -> Bool {
        return isIdle
    }
    
    public func handlePageResponse(objectCount: Int, error: NetworkingError?) {
        guard error == nil else {
            failureLoadingPage()
            return
        }
        successLoadingPage(objectCount: objectCount)
    }
    
    public func handleNoContent() {
        successLoadingPage(objectCount: 0)
    }
}

public protocol Pageable {
    var pagination: Pagination { get set }
    func shouldLoadNextPage() -> Bool
}

extension Pageable {
    public func shouldLoadNextPage() -> Bool {
        return pagination.shouldLoadNextPage()
    }
}
