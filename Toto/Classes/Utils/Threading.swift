//
//  Threading.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

/// Run the code in main thread.
///
/// - Parameters:
///   - skip: Skip check if current thread is main
///   - code: Your code
public func runAtMain(_ code: @escaping () -> Void) {
    if Foundation.Thread.isMainThread {
        code()
    } else {
        DispatchQueue.main.async {
            code()
        }
    }
}

