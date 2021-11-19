//
//  DetailLog.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/19.
//

import Foundation

class DetailLog: NSObject {
    static func Log<T>(_ message: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
#if DEBUG
    if let msg = message {
        print("\(Date()) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : \(msg)")
    } else {
        print("\(Date()) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName)")
    }
    #endif
    }
}
