//
//  StringUtils.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

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
