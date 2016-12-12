//
//  Module.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 12/11/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol JSModuleExport: JSExport {
    /// The `ModuleDelegate` running the module.
    static var delegate: JSValue { get }
}

public class JSModule: NSObject, JSModuleExport {
    public static var delegate: JSValue = JSValue()
}
