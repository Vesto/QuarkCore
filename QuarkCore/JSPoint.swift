//
//  JSPoint.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSPoint: JSAdapter {
    public static var jsClass: String = "Point"
    
    public let value: JSValue
    
    public var x: Double {
        return value.objectForKeyedSubscript("x").toDouble()
    }
    
    public var y: Double {
        return value.objectForKeyedSubscript("y").toDouble()
    }
    
    public required init?(value: JSValue) {
        guard value.isInstance(of: JSPoint.viewClass(context: value.context)) else {
            return nil
        }
        
        self.value = value
    }
    
    public required convenience init?(context: JSContext, x: Double, y: Double) {
        guard let value = JSPoint.viewClass(context: context).construct(withArguments: [x, y]) else {
            return nil
        }
        
        self.init(value: value)
    }
}