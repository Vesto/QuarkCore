//
//  QuarkModule.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 11/26/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import Foundation
import JavaScriptCore

/*
 Module file structure
 src/
    *.ts
 dist/
    build.js
    build.js.map
 resources/
    *.png
    *.jpeg
 info.json
*/

// TODO: rename to QK...

public enum QKModuleError: Error {
    case invalidInfo
    case noInfo
    case noSource
    case unableToIndexResources
}

public class QuarkModuleInfo {
    public let name: String
    public let version: String
    public let appDelegate: String
    
    convenience init(url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    internal init(data: Data) throws {
        // Parse the data into JSON and read parameters
        guard
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
            let name = json["name"] as? String,
            let version = json["version"] as? String,
            let appDelegate = json["app-delegate"] as? String
        else {
            throw QKModuleError.invalidInfo
        }
        
        // Save the parameters
        self.name = name
        self.version = version
        self.appDelegate = appDelegate
    }
}

public class QuarkResource {
    // Data
    public let url: URL
    public let name: String
    public let type: String
    
    // Properties
    var isImage: Bool { // TODO: More types? Maybe isReadableImage? Or what?
        return type == "png" || type == "jpg" || type == "jpeg"
    }
    
    public init(url: URL, name: String, type: String) {
        self.url = url
        self.name = name
        self.type = type
    }
}

public class QuarkModule {
    // Paths
    private static let infoPath = "info.json"
    private static let buildPath = "dist/build.js"
    private static let resourcePath = "resources/"
    
    /// The base URL for the module
    public private(set) var url: URL
    
    /// The URL for the info file.
    public var infoURL: URL {
        return url.appendingPathComponent(QuarkModule.infoPath, isDirectory: false)
    }
    
    /// The URL for the build source.
    public var buildURL: URL {
        return url.appendingPathComponent(QuarkModule.buildPath, isDirectory: false)
    }
    
    /// The URL for the resource folder.
    public var resourceURL: URL {
        return url.appendingPathComponent(QuarkModule.resourcePath, isDirectory: true)
    }
    
    /// The info data for the module.
    public private(set) var info: QuarkModuleInfo?
    
    /// The source for the module
    public private(set) var source: String?
    
    /// A list of all the resources in the module.
    public private(set) var resources: [QuarkResource]?
    
    /// Loads a module at a specified URL.
    public init(url: URL) throws {
        // Save the URL
        self.url = url
        
        // Load the info
        try loadInfo()
        
        // Load the source
        try loadSource()
        
        // Load the resources
        try indexResources()
    }
    
    /// (Re)loads the info file for the module.
    public func loadInfo() throws {
        // Load the info file
        self.info = try QuarkModuleInfo(url: infoURL)
    }
    
    /// (Re)loads the module's source.
    public func loadSource() throws {
        self.source = try String(contentsOf: buildURL)
    }
    
    /// Indexes the resources directory so files can be accessed quickly.
    public func indexResources() throws {
        // Create an enumerator for the files
        guard
            let enumerator = FileManager.default.enumerator(
                at: resourceURL,
                includingPropertiesForKeys: nil,
                options: [],
                errorHandler: { url, error -> Bool in
                    print("Error with resource file at url \(url) \(error)")
                    return true
                }
            )
        else {
            throw QKModuleError.unableToIndexResources
            return
        }
        
        // An index of all the resources
        var index = [QuarkResource]()
        
        // Loop through the enumerator
        for case let url as URL in enumerator {
            // Don't index directories
            guard url.isFileURL else {
                continue
            }
            
            // Get the file properties
            var fileURL = url
            let type = fileURL.pathExtension
            fileURL.deletePathExtension()
            let fileName = url.lastPathComponent
            
            // Save the resource
            index.append(QuarkResource(url: url, name: fileName, type: type))
        }
    }
    
    /// Executes the source in a context.
    public func `import`(intoContext context: JSContext) throws {
        // Make sure that the appropriate data is loaded
        guard let info = info else { throw QKModuleError.noInfo }
        guard let source = source else { throw QKModuleError.noSource }
        
        // Evaluates the source into the context
        context.evaluateScript(source)
    }
    
    /// Loads a resource of a specified name and type
    public func loadResource(named: String, withExtension: String) {
        // TODO: Load the resource
    }
}



