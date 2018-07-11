//
//  LogsUtils.swift
//  Common
//
//  Created by Nhuan Vu on 2/1/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import CocoaLumberjack

public func LogError(_ message: @autoclosure () -> String, tag: String? = nil, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogError(message, file: file, function: function, line: line, tag: tag)
}

public func LogWarn(_ message: @autoclosure () -> String, tag: String? = nil, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogWarn(message, file: file, function: function, line: line, tag: tag)
}

public func LogInfo(_ message: @autoclosure () -> String, tag: String? = nil, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogInfo(message, file: file, function: function, line: line, tag: tag)
}

public func LogDebug(_ message: @autoclosure () -> String, tag: String? = nil, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogDebug(message, file: file, function: function, line: line, tag: tag)
}

public func LogVerbose(_ message: @autoclosure () -> String, tag: String? = nil, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogVerbose(message, file: file, function: function, line: line, tag: tag)
}

