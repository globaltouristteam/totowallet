//
//  NetworkingServiceParams.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import Alamofire

/// Data for an API request
public class NetworkingServiceParams {
    
    public init() {
    }
    
    /// Http request parameters
    public var requestParams: [String: Any] = [:]
    
    /// Http request URL
    public var requestURL: String = ""
    
    /// Http request headers
    public var requestHeader = RequestHeader()
    
    /// Http request method
    public var requestMethod: HTTPMethod = .get

    /// Block to prepare data for http multipart-request
    public var requestMultipart: ((MultipartFormData) -> Void)?
    
    /// Send raw data with application/json encoding
    public var json: Bool = true
}
