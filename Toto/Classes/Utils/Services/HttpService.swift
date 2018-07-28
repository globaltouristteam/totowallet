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
    
    public func getTickers(offset: Int = 0, completionBlock: JsonObjectCompletionHandler<TicketResponse>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/ticker"
        params.json = false
        params.requestParams = [
            "convert": "BTC",
            "limit": 100,
            "sort": "rank",
            "start": offset
        ]
        callServer(TicketResponse.self, params, serviceCompletionBlock: completionBlock)
    }
    
}
