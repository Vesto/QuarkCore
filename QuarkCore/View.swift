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
public protocol View: JSExport, JSValueRetainer { // TODO: Z index
    /* JavaScript Interop */
    var jsView: JSValue { get set } // This should read or create a view // Should not be used directly from Swift, use JSValue since it's an optional
    
    /* Positioning */
    var jsRect: JSValue { get set }
    
    /* View hierarchy */
    var jsSubviews: [View] { get } // Index 0 = backmost
    
    var jsSuperview: View? { get }
    
    func jsAddSubview(_ view: View, _ index: Int)
    
    func jsRemoveFromSuperview()
    
    /* Events */
    
    
    /* Layout */
    
    
    /* Visibility */
    var jsHidden: Bool { get set }
    
    /* Style */
    var jsBackgroundColor: JSValue { get set } // Color
    var jsAlpha: Double { get set }
    var jsShadow: JSValue? { get set } // Shadow // Should be nil if don't want to render a shadow
    var jsCornerRadius: Double { get set }
    
    /* TODO: Animations like SpriteKit */
    
    /* Initiator */
    /// Creates a new view with a JSView.
    init()
}
