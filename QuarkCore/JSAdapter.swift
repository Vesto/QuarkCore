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
    var value: JSValue { get } // TODO: Weak reference somehow? Or should there be?
    init?(value: JSValue)
}

public extension JSAdapter {
    public static func viewClass(instance: QKInstance) -> JSValue { // TODO: Change this to QKInstance
        return instance.quarkModule.objectForKeyedSubscript(Self.jsClass)
    }
}
