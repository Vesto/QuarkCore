//
// Created by Nathan Flurry on 12/6/16.
// Copyright (c) 2016 Vesto. All rights reserved.
//

import Foundation

public protocol Swizzlable: class {
    static var swizzled: Bool { get set }
    static func swizzle()
}

public class Swizzler {
    /// Swizzle all the classes.
    public static func swizzle(classes: [Swizzlable.Type]) {
        // Swizzle every class that hasn't been swizzled yet
        for c in classes {
            guard !c.swizzled else { continue }
            c.swizzle()
            c.swizzled = true
        }
    }
}
