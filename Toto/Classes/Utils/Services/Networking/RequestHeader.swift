//
//  RequestHeader.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

let kAuthorizationKey = "Authorization"

open class RequestHeader {
    public init() {
    }
    
    func headers() -> [String: String] {
        return [:]
    }
}

public class SecureHeader: RequestHeader {
    open var accessToken: String?
    
    override func headers() -> [String: String] {
        var headers = super.headers()
        if let accessToken = accessToken {
            headers[kAuthorizationKey] = "Bearer \(accessToken)"
        }
        return headers
    }
}
