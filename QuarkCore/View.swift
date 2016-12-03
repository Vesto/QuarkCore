//
//  View.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 10/12/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

/*
 Notes:
 
 - Do not create any convenience methods that can be done in JavaScript.
    - This makes briding and easier across platforms.
    - Let JavaScript do the extension methods.
    - Same goes for initiators.
 - Can't use Self or generics because of @objc constraint.
 */

@objc
public protocol View: JSExport, JSValueRetainer {
    /* JavaScript Interop */
    var jsView: JSValue? { get set } // TODO: Assure weak reference
    
    /* Positioning */
    var jsRect: JSValue { get set }
    
    /* View hierarchy */
    var jsSubviews: [JSValue] { get }
    
    var jsSuperview: JSValue? { get }
    
    func jsAddSubview(_ view: JSValue)
    
    func jsRemoveFromSuperview()
    
    /* Events */
    
    
    /* Layout */
    
    
    /* Visibility */
    var jsHidden: Bool { get set }
    
    /* Style */
    var jsBackgroundColor: JSValue { get set } // Color
    var jsAlpha: Double { get set }
    var jsShadow: JSValue { get set } // Shadow
    var jsCornerRadius: Double { get set }
    
    /* TODO: Animations like SpriteKit */
    
    /* Initiator */
    /// Creates a new view with a JSView.
    init()
}

// Implement method for `JSValueRetainer`.
extension View {
    /// Creates a `JSView` instance.
    public static func createJSView(instance: QKInstance) -> JSView? {
        // Should be `createJSValue`, but causes error. 
        return JSView.jsView(instance: instance, view: Self())
    }

}
