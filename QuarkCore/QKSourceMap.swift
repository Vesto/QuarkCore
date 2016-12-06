//
//  QKSourceMap.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 12/3/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public class QKSourceMap {
    private let value: JSValue
    
    public init(sourceMap: String) {
        // Create a JSValue
        value = QKJSUtils.module
            .objectForKeyedSubscript("SourceMapUtil")
            .construct(withArguments: [sourceMap])
    }
    
    /// Returns the original position for a given line and column in the sourcemap.
    public func originalPositionFor(line: Int, column: Int) throws -> (Int, Int) {
        // Get the mapped values
        let mapped = value.invokeMethod("originalPositionFor", withArguments: [line, column])
        print(mapped?.toDictionary() ?? "Could not unwrap.")

        // Fetch the values
        guard
            let line = mapped?.objectForKeyedSubscript("line").toInt32(),
            let column = mapped?.objectForKeyedSubscript("column").toInt32()
        else {
            return (0,0)
        }
        
        // Return the values
        return (Int(line), Int(column))
    }
}
