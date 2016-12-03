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

extension JSValueRetainer {
    /// The associated key for storing the `JSValue`.
    private static var associatedKey: String {
        get {
            return "JSAssociatedValue"
        }
        set {
            // Has set so it can be used in `inout`.
            print("Tried to set \(newValue) as associated key.")
        }
    }
    
    /// Override of `jsValue` to allow for storing the value.
    public var jsValue: JSValue? {
        get {
            return objc_getAssociatedObject(self, &Self.associatedKey) as? JSValue
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &Self.associatedKey,
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
