//
//  Logger.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 10/12/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol LoggerExport: JSExport {
    /**
     Prints text to the console without a line break.
     
     - parameter text: The text to print to the console.
     */
    static func output(_ string: String)
}

@objc
public class Logger: NSObject, LoggerExport {
    public static func output(_ string: String) {
        Swift.print(string, terminator: "")
    }
}
