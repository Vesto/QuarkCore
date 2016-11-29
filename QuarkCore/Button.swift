//
//  Button.swift
//  QuarkExports
//
//  Created by Nathan Flurry on 10/12/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

@objc
public protocol Button: View, JSExport {
    var jsTitle: String { get set }
}
