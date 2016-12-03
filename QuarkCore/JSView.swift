//
//  JSView.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 11/25/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class JSView: JSAdapter {
    public static var jsClass: String = "View"
    
    public let value: JSValue
    
    public var nsView: NSView? {
        return value.objectForKeyedSubscript("view").toObject() as? NSView
    }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, view: View) {
        guard let value = JSView.viewClass(instance: instance).construct(withArguments: [view]) else {
            print("Could not construct \(JSView.jsClass) with arguments \(view).")
            return nil
        }
        
        self.init(value: value)
    }
    
    func layout() {
        value.invokeMethod("layout", withArguments: [])
    }
    
    public static func adapterClassForView(type: View.Type) -> JSView.Type {
        if type == Button.self {
            return JSView.self // TODO: JSButton.self
        } else {
            return JSView.self
        }
    }
    
    public static func jsView(instance: QKInstance, view: View) -> JSView? {
        return JSView.adapterClassForView(type: type(of: view)).init(instance: instance, view: view)
    }
}
