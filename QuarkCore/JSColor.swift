//
//  JSColor.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSColor: JSAdapter {
    public static var jsClass: String = "Color"
    
    public let value: JSValue
    
    public var red: Double {
        return value.objectForKeyedSubscript("red").toDouble()
    }
    
    public var green: Double {
        return value.objectForKeyedSubscript("green").toDouble()
    }
    
    public var blue: Double {
        return value.objectForKeyedSubscript("blue").toDouble()
    }
    
    public var alpha: Double {
        return value.objectForKeyedSubscript("alpha").toDouble()
    }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, red: Double, green: Double, blue: Double, alpha: Double) {
        guard let value = JSSize.viewClass(instance: instance).construct(withArguments: [red, green, blue, alpha]) else {
            print("Could not construct \(JSColor.jsClass) with arguments \(red), \(green), \(blue), \(alpha).")
            return nil
        }
        
        self.init(value: value)
    }
}
