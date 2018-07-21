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
    
    public func getTickers(_ completionBlock: JsonObjectCompletionHandler<ResponseBase<JsonObject>>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/ticker"
        params.json = false
        callServer(ResponseBase<JsonObject>.self, params, serviceCompletionBlock: completionBlock)
    }
    
}
