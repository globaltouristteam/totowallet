//
//  String+Json.swift
//  Common
//
//  Created by Nhuan Vu on 2/1/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

public extension String {
    
    /// Get json object from string
    ///
    /// - Returns: Json object
    public func jsonObject() -> [String: Any]? {
        do {
            let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
            if let data = data {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let json = json as? [String: Any] {
                    return json
                }
            }
        } catch {
            LogError("error serializing JSON: \(error)")
        }
        return nil
    }
    
    /// Get Json data from string
    ///
    /// - Returns: Json object or json array
    public func jsonData() -> Any? {
        do {
            let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
            if let data = data {
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .mutableContainers])
                
                if let json = json as? [String: Any] {
                    return json
                }
                if let json = json as? [Any] {
                    return json
                }
            }
        } catch {
            LogError("error serializing JSON: \(error)")
        }
        return nil
    }
}

