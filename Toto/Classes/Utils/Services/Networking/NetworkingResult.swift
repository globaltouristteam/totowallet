//
//  NetworkingResult.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkingResult {
    public var error: Error? = nil
    public var data: Any? = nil
    
    public init(error: Error?, data: Data? = nil) {
        self.error = error
        parseError(with: data)
    }
    
    public init(responseData: Any?) {
        self.data = responseData
    }
    
    func parseError(with data: Data?) {
        if let data = data, let json = data.json() {
            var message: String?
            var cause: String?
            var code: Int?
            if let m = json["error_description"] as? String {
                message = m
            }
            if let c = json["error"] as? String {
                cause = c
            }
            if let c = json["code"] as? Int {
                code = c
            }
            if let message = message, let code = code {
                self.error = TTError(message, code: code, cause: cause)
            }
        }
    }
    
    // MARK: Public
    public func isError() -> Bool {
        return error != nil
    }
    
    public func jsonData() -> [String: Any]? {
        return data as? [String: Any]
    }
    
    func jsonObject<T: JsonObject>() -> T? {
        guard let json = jsonData() else { return nil }
        return T.from(data: json)
    }
}
