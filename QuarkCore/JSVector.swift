//
//  JSVector.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 12/10/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSVector: JSAdapter {
    public static let jsClass: String = "Vector"
    
    public let value: JSValue
    
    public var x: Double {
        return value.objectForKeyedSubscript("x").toDouble()
    }
    
    public var y: Double {
        return value.objectForKeyedSubscript("y").toDouble()
    }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, x: Double, y: Double) {
        guard let value = JSVector.classValue(instance: instance).construct(withArguments: [x, y]) else {
            return nil
        }
        
        self.init(value: value)
    }
}
