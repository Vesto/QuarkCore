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
    static func print(_ text: String)
}

@objc
public class Logger: NSObject, LoggerExport {
    public static func print(_ text: String) {
        Swift.print(text, terminator: "")
    }
}
