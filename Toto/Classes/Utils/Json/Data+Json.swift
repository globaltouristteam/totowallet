//
//  Data+Json.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

extension Data {
    
    /// Convert object to json string
    ///
    /// - Returns: String
    public func jsonString() -> String? {
        return json()?.jsonString2()
    }
    
    /// Convert object to json
    ///
    /// - Returns: String
    public func json() -> [String: Any]? {
        do {
            let data = try JSONSerialization.jsonObject(with: self, options: [.allowFragments])
            return data as? [String: Any]
        } catch {
            LogError("error de-serializing JSON: \(error)")
        }
        return nil
    }
}
