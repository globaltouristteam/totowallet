//
//  Array+Json.swift
//  Common
//
//  Created by Nhuan Vu on 2/1/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

public extension Array where Element: Any  {
    
    /// Convert an array to json string
    ///
    /// - Returns: String
    public func jsonString() -> String? {
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

