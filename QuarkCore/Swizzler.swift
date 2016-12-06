//
// Created by Nathan Flurry on 12/6/16.
// Copyright (c) 2016 Vesto. All rights reserved.
//

import Foundation

public protocol Swizzlable {
    static func swizzle()
}

public class Swizzler {
    /// If Swizzler has swizzled the classes yet
    public private(set) static var hasSwizzled = false

    /// A list of classes to swizzle
    public static var classesToSwizzle: [Swizzlable.Type] = []

    /// Swizzle all the classes.
    public static func swizzle() {
        // Make sure nothing has been swizzled.
        guard !Swizzler.hasSwizzled else {
            return
        }

        // Swizzle every class
        for c in classesToSwizzle {
            c.swizzle()
        }

        // Save swizzled
        Swizzler.hasSwizzled = true
    }
}
