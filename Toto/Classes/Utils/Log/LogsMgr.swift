//
//  LogsMgr.swift
//  Common
//
//  Created by Nhuan Vu on 2/1/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import CocoaLumberjack

extension DDLogLevel {
    init(name: String) {
        switch name {
        case "All":
            self = .all
        case "Error":
            self = .error
        case "Warning":
            self = .warning
        case "Info":
            self = .info
        case "Debug":
            self = .debug
        case "Verbose":
            self = .verbose
        case "Off":
            self = .off
        default:
            self = .off
        }
    }
    
    func name() -> String {
        switch self {
        case .all:
            return "All"
        case .off:
            return "Off"
        case .error:
            return "Error"
        case .warning:
            return "Warning"
        case .info:
            return "Info"
        case .debug:
            return "Debug"
        case .verbose:
            return "Verbose"
        }
    }
}

public class LogsMgr {
    
    public init() {
    }
    
    public func configLogger() {
        defaultDebugLevel = DDLogLevel(name: "Debug")
        
        let formatter = LogFormatter()
        formatter.useIcon = true
        DDTTYLogger.sharedInstance.logFormatter = formatter
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        #if !DEBUG
            DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
        #endif
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 5
        fileLogger.logFormatter = LogFormatter()
        DDLog.add(fileLogger)
        
        let logFileInfo = fileLogger.currentLogFileInfo
        LogInfo("Log file: \(logFileInfo?.filePath ?? "")")
        LogVerbose("Verbose")
        LogDebug("Debug")
        LogInfo("Info")
        LogWarn("Warn")
        LogError("Error")
    }
    
    public func logs() -> String {
        var log: String = ""
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        let logFiles = fileLogger.logFileManager.sortedLogFileInfos.reversed()
        for file in logFiles {
            let data = FileManager.default.contents(atPath: file.filePath)
            if data != nil && data!.count > 0 {
                if let string = String(data: data!, encoding: String.Encoding.utf8) {
                    log += "\(string)\n=========================\nNext file\n=========================\n"
                }
            }
        }
        return log
    }
    
    public func changeLogLevel(to level: UInt) {
        if let level = DDLogLevel(rawValue: level) {
            defaultDebugLevel = level
        }
    }
    
    public func supportedLogLevel() -> [UInt: String] {
        let levels: [DDLogLevel] = [.all, .verbose, .debug, .info, .warning, .error, .off]
        var supported: [UInt: String] = [:]
        for level in levels {
            var name = level.name()
            if level == defaultDebugLevel {
                name += " *"
            }
            supported[level.rawValue] = name
        }
        return supported
    }
}
