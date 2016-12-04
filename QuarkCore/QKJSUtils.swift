//
//  QKJSUtils.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 12/3/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class QKJSUtils {
    /// The context in which the utils run
    public static let context: JSContext = {
        let context = JSContext()!
//        context.setObject(
//            { (string: String) -> Void in
//                print(string)
//            },
//            forKeyedSubscript: NSString(string: "log")
//        )
        
        var block : @convention(block) (NSString!) -> Void = { string in
            print(string)
        }
        
        context.setObject(
            unsafeBitCast(block, to: AnyObject.self),
            forKeyedSubscript: NSString(string: "log")
        )
        
        context.exceptionHandler = { context, value in
            guard let value = value else {
                print("⚠️ Unkown utils error.")
                return
            }
            print("⚠️ Utils error: \(value) \(value.toDictionary())")
        }
        context.evaluateScript(script)
        return context
    }()
    
    /// The utils script 
    public static var script: String {
        guard let url = Bundle(for: QKJSUtils.self).url(forResource: "quark-utils", withExtension: "js") else {
            return ""
        }
        return (try? String(contentsOf: url)) ?? ""
    }
    
    /// The module in which the utils reside.
    public static var module: JSValue {
        return context.objectForKeyedSubscript("utils")
    }
}
