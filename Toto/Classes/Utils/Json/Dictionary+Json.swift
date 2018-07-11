//
//  Dictionary+Json.swift
//  Common
//
//  Created by Nhuan Vu on 2/1/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /// Convert json to string
    ///
    /// - Returns: String
    public func jsonString2() -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self as AnyObject, options: [])
            let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            return datastring as String?
        } catch {
            LogError("error de-serializing JSON: \(error)")
        }
        return nil
    }
}

