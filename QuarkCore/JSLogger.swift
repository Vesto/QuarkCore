//
//  JSLogger.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 10/12/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol JSLoggerExport: JSExport {
    /**
     Prints text to the console without a line break.
     
     - parameter text: The text to print to the console.
     */
    static func output(_ string: String)
}

@objc
public class JSLogger: NSObject, JSLoggerExport {
    public static func output(_ string: String) {
        // Prints witout a new line break
        Swift.print(string, terminator: "")
    }
}
