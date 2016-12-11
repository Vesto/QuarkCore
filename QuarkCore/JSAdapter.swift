//
//  JSAdapter.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol JSAdapter {
    static var jsClass: String { get }
    var value: JSValue { get } // TODO: Weak reference somehow? Or should there be?
    init?(value: JSValue)
}

public extension JSAdapter {
    public static func classValue(instance: QKInstance) -> JSValue { // TODO: Change the name of this method
        return instance.quarkLibrary.objectForKeyedSubscript(Self.jsClass)
    }
}
