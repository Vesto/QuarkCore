//
//  JavaScriptCore+Magic.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/30/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

extension JSContext {
    fileprivate struct AssociatedKeys {
        static var Instance = "JSContextInstance"
    }

    public internal(set) var instance: QKInstance? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Instance) as? QKInstance
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                        self,
                        &AssociatedKeys.Instance,
                        newValue,
                        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
