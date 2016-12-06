//
//  JavaScriptCore+Magic.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/30/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

/// Associated value for storing `instance` on JSContext objects.
var JSContextInstanceAssociatedKey = "JSContextInstance"

extension JSContext {
    public internal(set) var instance: QKInstance? {
        get {
            return objc_getAssociatedObject(self, &JSContextInstanceAssociatedKey) as? QKInstance
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                        self,
                        &JSContextInstanceAssociatedKey,
                        newValue,
                        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
