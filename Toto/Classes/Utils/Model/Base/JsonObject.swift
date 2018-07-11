//
//  JsonObject.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

protocol JsonConvertible {
    
    /// Get json data from object
    ///
    /// - Returns: Json data
    func json() -> [String: Any]?
    
    /// Get json string from object
    ///
    /// - Returns: Json data in string
    func jsonString() -> String?
    
    /// Parse `Data` to `JsonObject`
    ///
    /// - Parameter data: Data
    /// - Returns: JsonObject
    static func from(data: Data) -> Self?
    
    /// Parse json data to `JsonObject`
    ///
    /// - Parameter data: Json data
    /// - Returns: JsonObject
    static func from(data: [String: Any]) -> Self?
}

open class JsonObject: Codable, JsonConvertible {

    static public func from(data: [String: Any]) -> Self? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) {
            return from(data: jsonData)
        }
        return nil
    }

    static public func from(data: Data) -> Self? {
        return try? JSONDecoder().decode(self, from: data)
    }

    public func json() -> [String: Any]? {
        if let data = try? JSONEncoder().encode(self) {
            return data.json()
        }
        return nil
    }

    public func jsonString() -> String? {
        return json()?.jsonString2()
    }
    
    public init() {
    }
}
