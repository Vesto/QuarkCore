//
//  JSSize.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSSize: JSAdapter {
    public static var jsClass: String = "Size"
    
    public let value: JSValue
    
    public var width: Double {
        return value.objectForKeyedSubscript("width").toDouble()
    }
    
    public var height: Double {
        return value.objectForKeyedSubscript("height").toDouble()
    }
    
    public required init?(value: JSValue) {
        guard value.isInstance(of: JSSize.viewClass(context: value.context)) else {
            return nil
        }
        
        self.value = value
    }
    
    public required convenience init?(context: JSContext, width: Double, height: Double) {
        guard let value = JSSize.viewClass(context: context).construct(withArguments: [width, height]) else {
            return nil
        }
        
        self.init(value: value)
    }
}