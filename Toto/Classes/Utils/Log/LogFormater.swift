//
//  LogFormater.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import CocoaLumberjack

class LogFormatter: NSObject, DDLogFormatter {
    var useIcon: Bool = true
    let dateFormatter: DateFormatter
    
    override public init() {
        dateFormatter = DateFormatter()
        dateFormatter.formatterBehavior = .behavior10_4
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        super.init()
    }
    
    public func format(message logMessage: DDLogMessage) -> String? {
        let dateAndTime = dateFormatter.string(from: logMessage.timestamp)
        var log = String(format: "%@ [%@] - %@.%@ at line %d:", dateAndTime, logFlagName(logMessage.flag), logMessage.fileName, logMessage.function ?? "", logMessage.line)
        if let tag = logMessage.tag as? String {
            log = String(format: "%@ TAG: %@;", log, tag)
        }
        log = String(format: "%@ %@", log, logMessage.message)
        return log
    }
    
    public func logFlagName(_ flag: DDLogFlag) -> String {
        switch flag {
        case .error:
            return useIcon ? "❌ Error" : "Error"
        case .warning:
            return useIcon ? "🔶 Warning" : "Warning"
        case .info:
            return useIcon ? "🔷 Info" : "Info"
        case .debug:
            return useIcon ? "◾️ Debug" : "Debug"
        case .verbose:
            return useIcon ? "◽️ Verbose" : "Verbose"
        default:
            return ""
        }
    }
}

