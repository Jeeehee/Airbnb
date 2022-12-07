import Foundation
import OSLog

enum Log {
    static func info(_ message: String) {
        printLog(logType: .info, message: message)
    }
    
    static func error(_ message: String) {
        printLog(logType: .error, message: message)
    }
    
    static func debug(_ message: String) {
        printLog(logType: .debug, message: message)
    }
    
    static func printLog(logType: OSLogType, message: String) {
        os_log(logType, log: .default, "\(message)")
    }
}
