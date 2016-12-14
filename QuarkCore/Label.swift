//
//  Label.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 12/11/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol Label: View, JSExport {
    var jsText: String { get set }
    var jsFont: JSValue { get set }
    var jsColor: JSValue { get set }
    var jsLineCount: Int { get set } // 0 = unlimited
    var jsLineBreakMode: UInt { get set }
    var jsAlignmentMode: UInt { get set }
}
