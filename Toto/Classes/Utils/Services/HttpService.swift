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
    
    public func getTours(_ completionBlock: JsonObjectCompletionHandler<ResponseBase<Tour>>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/tour_list"
        params.json = false
        
        callServer(ResponseBase<Tour>.self, params, serviceCompletionBlock: completionBlock)
    }
    
    public func search(duration: String?, departure: String?, destination: String?, _ completionBlock: JsonObjectCompletionHandler<ResponseBase<Tour>>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/search"
        params.json = false
        var data: [String: String] = [:]
        if let duration = duration {
            data["day"] = duration
        }
        if let departure = departure {
            data["depart"] = departure
        }
        if let destination = destination {
            data["des"] = destination
        }
        params.requestParams = data

        callServer(ResponseBase<Tour>.self, params, serviceCompletionBlock: completionBlock)
    }

    public func getTourDetails(_ id: String, completionBlock: JsonObjectCompletionHandler<Tour>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/tour_details/\(id)"
        params.json = false
        
        callServer(ResponseBase<Tour>.self, params) { (tours, error) in
            if let tour = tours?.list?.first {
                completionBlock?(tour, nil)
            } else {
                completionBlock?(nil, error)
            }
        }
    }

}
