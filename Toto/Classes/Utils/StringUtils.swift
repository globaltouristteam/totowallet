//
//  StringUtils.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

func localizedString(forKey key: String) -> String {
    let bundle = Bundle.main
    var result = bundle.localizedString(forKey: key, value: nil, table: nil)
    
    if result == key {
        result = bundle.localizedString(forKey: key, value: nil, table: "Toto")
    }
    
    return result
}

public class StringUtils {

    /// Check string null or empty
    ///
    /// - Parameter string: Given string
    /// - Returns: True if string is nil or empty. Otherwise return false
    public class func isEmpty(_ string: String?) -> Bool {
        if string != nil {
            return string!.isEmpty
        }
        return true
    }
}
