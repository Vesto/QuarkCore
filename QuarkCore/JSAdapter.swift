//
//  JSAdapter.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public protocol JSAdapter {
    static var jsClass: String { get }
    static func viewClass(context: JSContext) -> JSValue
    var value: JSValue { get } // TODO: Weak reference somehow? Or should there be?
    init?(value: JSValue)
}

public extension JSAdapter {
    static func viewClass(context: JSContext) -> JSValue {
        return context.objectForKeyedSubscript(self.jsClass)
    }
}
