//
//  Events.swift
//  QuarkCore
//
//  Created by Nathan Flurry on 12/8/16.
//  Copyright © 2016 Vesto. All rights reserved.
//

import JavaScriptCore

public enum JSEventPhase: Int32 {
    case began, changed, stationary, ended, cancelled
}

public class JSInteractionEvent: JSAdapter {
    public enum JSInteractionType: UInt32 {
        case touch, stylus, hover, leftMouse, rightMouse, otherMouse
    }
    
    public static let jsClass: String = "InteractionEvent"
    public let value: JSValue
    
    public var time: Double { return value.objectForKeyedSubscript("time").toDouble() }
    public var type: JSInteractionType? { return JSInteractionType(rawValue: value.objectForKeyedSubscript("type").toUInt32()) }
    public var phase: JSEventPhase? { return JSEventPhase(rawValue: value.objectForKeyedSubscript("phase").toInt32()) }
    public var location: JSPoint? { return JSPoint(value: value.objectForKeyedSubscript("location")) }
    public var count: UInt32 { return value.objectForKeyedSubscript("count").toUInt32() }
    public var pressure: Double { return value.objectForKeyedSubscript("pressure").toDouble() }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, time: Double, type: JSInteractionType, phase: JSEventPhase, location: JSPoint, count: UInt32, pressure: Double) {
        guard let value = JSInteractionEvent.classValue(instance: instance).construct(withArguments: [
            time,
            type.rawValue,
            phase.rawValue,
            location.value,
            count,
            pressure
        ]) else {
            return nil
        }
        
        self.init(value: value)
    }
}

public class JSKeyEvent: JSAdapter {
    public enum JSKeyPhase: UInt32 {
        case keyDown, keyUp
    }
    
    public enum JSKeyModifier: UInt32 {
        case control, option, meta, shift, capsLock
    }
    
    public static let jsClass: String = "KeyEvent"
    public let value: JSValue
    
    public var time: Double { return value.objectForKeyedSubscript("time").toDouble() }
    public var phase: JSKeyPhase? { return JSKeyPhase(rawValue: value.objectForKeyedSubscript("phase").toUInt32()) }
    public var isRepeat: Bool { return value.objectForKeyedSubscript("isRepeat").toBool() }
    public var keyCode: UInt32 { return value.objectForKeyedSubscript("keyCode").toUInt32() }
    public var modifiers: [JSKeyModifier] {
        return value.objectForKeyedSubscript("modifiers").toArray()
            .map { $0 as? UInt32 }.filter { $0 != nil }.map { $0! } // TODO: Extend array for .filer {}.map {} to ".unwrapAll()"
            .map { JSKeyModifier(rawValue: $0) }.filter { $0 != nil }.map { $0! }
    }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, time: Double, phase: JSKeyPhase, isRepeat: Bool, keyCode: UInt32, modifiers: [JSKeyModifier]) {
        guard let value = JSKeyEvent.classValue(instance: instance).construct(withArguments: [
            time,
            phase.rawValue,
            isRepeat,
            keyCode,
            modifiers.map { $0.rawValue }
        ]) else {
                return nil
        }
        
        self.init(value: value)
    }
}

public class JSScrollEvent: JSAdapter {
    public enum JSInteractionType: UInt32 {
        case touch, stylus, hover, leftMouse, rightMouse, otherMouse, scrollWheel
    }
    
    public static let jsClass: String = "ScrollEvent"
    public let value: JSValue
    
    public var time: Double { return value.objectForKeyedSubscript("time").toDouble() }
    public var phase: JSEventPhase? { return JSEventPhase(rawValue: value.objectForKeyedSubscript("phase").toInt32()) }
    public var location: JSPoint? { return JSPoint(value: value.objectForKeyedSubscript("location")) }
    public var deltaScroll: JSVector? { return JSVector(value: value.objectForKeyedSubscript("deltaScroll")) }
    
    public required init?(value: JSValue) {
        self.value = value
    }
    
    public required convenience init?(instance: QKInstance, time: Double, phase: JSEventPhase, location: JSPoint, deltaScroll: JSVector) {
        guard let value = JSScrollEvent.classValue(instance: instance).construct(withArguments: [
            time,
            phase.rawValue,
            location.value,
            deltaScroll.value
        ]) else {
                return nil
        }
        
        self.init(value: value)
    }
}
