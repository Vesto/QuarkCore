//
//  JSShadow.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSShadow: JSAdapter {
    public static let jsClass: String = "Shadow"
    
    public let value: JSValue
    
    public var offset: JSPoint? {
        return JSPoint(value: value.objectForKeyedSubscript("offset"))
    }
    
    public var blurRadius: Double {
        return value.objectForKeyedSubscript("blurRadius").toDouble()
    }
    
    public var color: JSColor? {
        return JSColor(value: value.objectForKeyedSubscript("color"))
    }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, offset: JSPoint, blurRadius: Double, color: JSColor) {
        guard let value = JSSize.classValue(instance: instance).construct(withArguments: [offset.value, blurRadius, color.value]) else {
            return nil
        }
        
        self.init(value: value)
    }
}
