//
//  TTError.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import Alamofire

public struct TTError: Error, LocalizedError {
    let message: String
    let cause: String?
    let code: Int
    
    public init(_ message: String, code: Int = 0, cause: String? = nil) {
        self.message = message
        self.code = code
        self.cause = cause
    }
    
    public var localizedDescription: String {
        return message
    }
    
    public var errorDescription: String? {
        return message
    }
    
    public var failureReason: String? {
        return cause
    }
}

extension Error {
    public var responseCode: Int? {
        if let error = self as? TTError {
            return error.code
        }
        if let error = self as? AFError {
            return error.responseCode
        }
        return nil
    }
}
