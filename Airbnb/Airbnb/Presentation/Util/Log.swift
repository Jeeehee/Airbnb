//
//  Log.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/02.
//

import Foundation
import OSLog

enum Log {
    // 에러 설명이 긴 경우
    static func info(_ message: String) {
        printLog(logType: .info, message: message)
    }
    
    // 에러 설명이 짧은 경우
    static func error(_ message: String) {
        printLog(logType: .error, message: message)
    }
    
    // 간단한 로깅 (mac의 '콘솔'앱에는 찍히지 않고 xcode console에만 표출)
    static func debug(_ message: String) {
        printLog(logType: .debug, message: message)
    }
    
    static func printLog(logType: OSLogType, message: String) {
        os_log(logType, log: .default, "\(message)")
    }
}
