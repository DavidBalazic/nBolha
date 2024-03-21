//
//  EQNetworking
//  Copyright © 2022 Equaleyes Ltd. All rights reserved.
//

import Foundation

// TODO: mapper should be the only generic constraint
open class BasePaginationWorker<T: ModelResponse, U: Model, V: ModelMapper<T, U>>: APICallWorker, Pageable {
    public typealias Completion = (U?, NetworkingError?) -> Void
    
    open var completion: Completion?
    open var items: U?
    
    open var pagination = Pagination()
    open var isLoading = false
    
    open var requestData: RequestModelData?
    
    open func loadFirstPage(requestData: RequestModelData? = nil, completion: @escaping Completion) {
        self.completion = completion
        self.requestData = requestData
        pagination.firstPageLoad()
        isLoading = true
        execute()
    }
    
    open func fetchNextPage(completion: @escaping Completion) {
        items = nil
        guard pagination.shouldLoadNextPage() else { return }
        pagination.nextPageLoad()
        self.completion = completion
        isLoading = true
        execute()
    }
    
    override open func processResponse(response: HTTPResponse) {
        guard let data = response.data,
              let page = T.parse(from: data, type: T.self) else {
                  return
              }
        
        let mapper = V()
        items = mapper.getModel(from: page)
        
        if let castedItems = items as? [U], castedItems.isEmpty {
            items = nil
            pagination.handleNoContent()
            return
        }
        
        pagination.handlePageResponse(objectCount: (items as? [U])?.count ?? 0, error: response.error)
    }
    
    override open func apiCallDidFinish(response: HTTPResponse) {
        isLoading = false
        completion?(items, response.error)
    }
    
    override open func getParameters() -> [String: Any] {
        return requestData?.getParameters() ?? [:]
    }
}
