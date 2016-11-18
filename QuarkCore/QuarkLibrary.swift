//
//  QuarkLibrary.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/16/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import AppKit

public enum QKLibraryError: Error {
    case failedToFindLibrary
}

public class QuarkLibrary {
    /// Returns the URL to the built library file.
    public static func getLibrary() throws -> URL {
        // Get the proper bundle
        // Use this instead of `Bundle(identifier: "com.Vest.QuarkCore")`
        // it doesn't force a specific bundle ID
        let bundle = Bundle(for: QuarkLibrary.self)
        
        // Get the URL of the library folder
        guard let buildUrl = bundle.url(
            forResource: "build",
            withExtension: "js",
            subdirectory: "Quark Library/dist"
        ) else {
            throw QKLibraryError.failedToFindLibrary
        }
        
        return buildUrl
    }
}
