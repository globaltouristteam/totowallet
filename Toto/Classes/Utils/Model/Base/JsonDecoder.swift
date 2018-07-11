//
//  JsonDecoder.swift
//  Common
//
//  Created by Nhuan Vu on 5/10/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
    /// Decodes a value of the given type for the given keys, if present. If found value with a key in list, ignore all other keys.
    ///
    /// This method returns `nil` if the container does not have a value associated with `key`, or if the value is null. The difference between these states can be distinguished with a `contains(_:)` call.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A decoded value of the requested type, or `nil` if the `Decoder` does not have an entry associated with the given key, or if the value is a null value.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
    public func decodeIfPresent<T>(_ type: T.Type, forKeys keys: [KeyedDecodingContainer<K>.Key]) throws -> T? where T: Decodable, K: CodingKey {
        for key in keys {
            if let data = try decodeIfPresent(type, forKey: key) {
                return data
            }
        }
        return nil
    }
}

