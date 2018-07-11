//
//  HttpService.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class HttpService: NetworkingService {
    static let shared = HttpService()
    
    public func getCategories(_ completionBlock: JsonObjectCompletionHandler<ResponseBase<Category>>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/categories_list"
        params.json = false

        callServer(ResponseBase<Category>.self, params, serviceCompletionBlock: completionBlock)
    }
    
    public func getTours(_ completionBlock: JsonObjectCompletionHandler<ResponseBase<Category>>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/tour_list"
        params.json = false
        
        callServer(ResponseBase<Category>.self, params, serviceCompletionBlock: completionBlock)
    }
    
    public func search(_ completionBlock: JsonObjectCompletionHandler<ResponseBase<Category>>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/search"
        params.json = false
        
        callServer(ResponseBase<Category>.self, params, serviceCompletionBlock: completionBlock)
    }

}
