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
    case failedToEnumerateLibrary
}

public class QuarkLibrary {
    /// Returns the paths for each JavaScript resource.
    public static func getLibraryFiles() throws -> [URL] {
        // Get the proper bundle
        // Use this instead of `Bundle(identifier: "com.Vest.QuarkCore")`
        // it doesn't force a specific bundle ID
        let bundle = Bundle(for: QuarkLibrary.self)
        
        // Get the URL of the library folder
        guard let libraryURL = bundle.url(forResource: "Quark Library", withExtension: nil) else {
            throw QKLibraryError.failedToFindLibrary
        }
        
        // Get the enumerator for the file maanger
        guard
            let enumerator = FileManager.default.enumerator(
                at: libraryURL,
                includingPropertiesForKeys: [],
                options: .skipsHiddenFiles,
                errorHandler: { _, _ in true } // Do nothing
            )
        else {
            throw QKLibraryError.failedToEnumerateLibrary
        }
        
        // Filter out the JS files
        let jsFiles = enumerator
            .map { $0 as? URL } // Safely map to URL
            .filter { $0?.pathExtension == "js" } // Filter to JS files and non-nil
            .map { $0! } // Unwrap all values (safe because of `filter`)
        
        return jsFiles
    }
}
