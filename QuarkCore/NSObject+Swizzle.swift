//
//  NSObject+Swizzle.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import ObjectiveC

// MARK: Swizzling
extension NSObject {
    public static func hookTo(original originalSelector: Selector, swizzled swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(
            self, originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
//    public func getAssociated(key: inout String) -> Any? {
//        return objc_getAssociatedObject(self, key)
//    }
//    
//    public func setAssociated(value: Any, key: inout String, association: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
//        objc_setAssociatedObject(self, key, value, association)
//    }
}
