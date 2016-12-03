//
//  JSRect.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSRect: JSAdapter {
    public static var jsClass: String = "Rect"
    
    public let value: JSValue
    
    public var point: JSPoint? {
        return JSPoint(value: value.objectForKeyedSubscript("point"))
    }
    
    public var size: JSSize? {
        return JSSize(value: value.objectForKeyedSubscript("size"))
    }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, point: JSPoint, size: JSSize) {
        guard let value = JSRect.viewClass(instance: instance).construct(withArguments: [point.value, size.value]) else {
            return nil
        }
        
        self.init(value: value)
    }
}

