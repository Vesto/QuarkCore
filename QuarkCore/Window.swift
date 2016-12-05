//
//  Window.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/30/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol Window: JSExport {
    /* JavaScript Interop */
    var jsWindow: JSWindow! { get }
    
    // The root view
    var jsRootView: JSValue { get set }
}
