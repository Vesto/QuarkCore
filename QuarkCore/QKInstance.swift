//
//  QKInstance.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/30/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

// TODO: Parse sourcemaps for original source location https://github.com/mozilla/source-map
@objc
public class QKInstance: NSObject {
    /// The prefix for all the exports if classes
    private let exportsPrefix = "QK"
    
    /// A map of the classes to export to the `JSContext`
    private let exports: [String: Any]
    
    /// The module that this Quark instance is based on.
    public let module: QKModule
    
    /// The JavaScript module object.
    public var jsModule: JSValue {
        return module.module(in: context)
    }
    
    /// The Quark library module.
    public var quarkLibrary: JSValue {
        return context.objectForKeyedSubscript("quark")
    }
    
    /// The app delegate.
    public private(set) var appDelegate: JSValue = JSValue()
    
    /// The context in which the main script runs in
    public let context: JSContext
    
    /// Wether or not Quark is running
    public private(set) var running: Bool = false
    
    /**
     Creates a new Quark instance and starts it.
     
     - parameter script: The JavaScript script to execute.
     - parameter virtualMachine: An optional virtual machine that can be
     provided.
     */
    public init(module: QKModule, exports: [String: Any], virtualMachine: JSVirtualMachine? = nil) throws {
        // Create the context
        if let virtualMachine = virtualMachine {
            context = JSContext(virtualMachine: virtualMachine)
        } else {
            context = JSContext()
        }
        
        // Save the exports
        self.exports = exports
        
        // Save the URL
        self.module = module
        
        super.init()

        // Assign the instance to the context
        context.instance = self
        
        // Add the exports to the context
        let exportsObject = JSValue(newObjectIn: context)! // TODO: Safety
        for (key, object) in exports {
            exportsObject.setObject(object, forKeyedSubscript: NSString(string: exportsPrefix + key))
        }
        context.setObject(exportsObject, forKeyedSubscript: NSString(string: "quark-native"))
        
        // Import the program into the context
        try module.import(intoContext: context)

        // Creates and saves an app delegate
        appDelegate = jsModule.objectForKeyedSubscript(module.info.delegate).construct(withArguments: [])

        // TODO: Need to check that quark was loaded from the bundle before executing
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    /**
     Starts the Quark instance, consequently showing the window and
     executing the script.
     */
    public func start(window: Window) {
        guard !running else {
            return
        }

        // Call the appropriate method on the app delegate // TODO: Call rest of init methods on delegate
        appDelegate.invokeMethod("createInterface", withArguments: [window.jsWindow.value])

        // Save the running state
        running = true
    }
}

