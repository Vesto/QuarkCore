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
        guard value.isInstance(of: JSView.viewClass(context: value.context)) else {
            Swift.print("Could not convert JSValue \(value) to JSView.")
            return nil
        }
        
        self.value = value
    }
    
    public required convenience init?(context: JSContext, view: View) {
        guard let value = JSView.viewClass(context: context).construct(withArguments: [view]) else {
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
    
    public static func jsView(context: JSContext, view: View) -> JSView? {
        return JSView.adapterClassForView(type: type(of: view)).init(context: context, view: view)
    }
}
