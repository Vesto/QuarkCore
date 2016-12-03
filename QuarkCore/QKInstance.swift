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
    public var quarkModule: JSValue {
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
        
        // Add the exports to the context
        for (key, object) in exports {
            context.setObject(object, forKeyedSubscript: NSString(string: exportsPrefix + key))
        }
        
        // Import the quark library
        if let quarkBundleURL = Bundle(for: QKInstance.self).url(forResource: "bundle", withExtension: "js") {
            let quarkBundle = try String(contentsOf: quarkBundleURL)
            context.evaluateScript(quarkBundle)
        } else {
            print("Could not import Quark library.")
        }
        
        
        // Import the program into the context
        do {
            try module.import(intoContext: context)
        } catch {
            print("Could not import module. \(error)")
        }
        
        super.init()
        
        // Creates and saves an app delegate
        appDelegate = jsModule.objectForKeyedSubscript(module.info.delegate).construct(withArguments: [])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    /**
     Starts the Quark instance, concequently showing the window and
     executing the script.
     */
    public func start(window: Window) {
        if !running {
            print(appDelegate.toDictionary())
            // Call the appropriate method on the app delegate // TODO: Call rest of init methods on delgate
            appDelegate.invokeMethod("createInterface", withArguments: [window.jsWindow.value])
            
            // Save the running state
            running = true
        }
    }
}

