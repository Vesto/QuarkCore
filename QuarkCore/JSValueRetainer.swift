//
//  JSValueRetainer.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/30/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

/// Retains a JSValue associated to the NSObject.
@objc
public protocol JSValueRetainer: class {
    /// Create a `JSValue` to be stored.
    static func createJSValue(instance: QKInstance) -> JSValue?
}

/// Associated value for storing `jsValue` objects. Has to be global since can't store values in extensions.
var JSValueRetainerAssociatedKey = "JSAssociatedValue"

extension JSValueRetainer {
    /// Override of `jsValue` to allow for storing the value.
    public var jsValue: JSValue? {
        get {
            return objc_getAssociatedObject(self, &JSValueRetainerAssociatedKey) as? JSValue
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &JSValueRetainerAssociatedKey,
                    newValue,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    /// Attempts to read value or creates it if nil and returns it.
    public func readOrCreateJSValue(instance: QKInstance) -> JSValue {
        if let value = jsValue {
            return value
        } else if let value = Self.createJSValue(instance: instance) {
            jsValue = value
            return value
        } else {
            print("Could not create JSValue for JSValueRetainer \(self).")
            return JSValue()
        }
    }
}
