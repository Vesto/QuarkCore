//
//  JSWindow.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/30/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSWindow: JSAdapter {
    public static var jsClass: String = "Window"
    
    public let value: JSValue
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, window: Window) {
        guard let value = JSWindow.viewClass(instance: instance).construct(withArguments: [window]) else {
            print("Could not construct \(JSWindow.jsClass) with arguments \(window).")
            return nil
        }
        
        self.init(value: value)
    }
}
