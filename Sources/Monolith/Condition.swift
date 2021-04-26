//
//  File.swift
//  
//
//  Created by Joshua Clark on 3/1/21.
//

import Foundation
import Datable


protocol Condition {
    func Evaluate(value: Any) -> Bool
}

struct EqualsCondition {
    var other: Any
}

extension EqualsCondition {
    // TODO: Reflecting/Mirror doesnt seem to have what we need.
    mutating func Evaluate(value: Any) -> Bool {
        guard let a = convertToInt64(value: value) else {
            return false
        }
        
        guard let b = convertToInt64(value: self.other) else {
            return false
        }
        
        return a == b
    }
}

struct GreaterCondition {
    var other: Any
}

extension GreaterCondition {
    mutating func Evaluate(value: Any) -> Bool {
        guard let a = convertToInt64(value: value) else {
            return false
        }
        
        guard let b = convertToInt64(value: self.other) else {
            return false
        }
        
        return a > b
    }
}

struct LesserCondition {
    var other: Any
}

extension LesserCondition {
    mutating func Evaluate(value: Any) -> Bool {
        guard let a = convertToInt64(value: value) else {
        return false
    }
    
        guard let b = convertToInt64(value: self.other) else {
        return false
    }
    
    return a < b
    }
}
func convertToInt64(value: Any) -> Int64? {
    switch value {
    case let intValue as Int:
        return Int64(intValue)
    case let intValue as UInt:
        return Int64(intValue)
    case let intValue as Int8:
        return Int64(intValue)
    case let intValue as UInt8:
        return Int64(intValue)
    case let intValue as Int16:
        return Int64(intValue)
    case let intValue as UInt16:
        return Int64(intValue)
    case let intValue as Int32:
        return Int64(intValue)
    case let intValue as UInt32:
        return Int64(intValue)
    case let intValue as Int64:
        return Int64(intValue)
    case let intValue as UInt64:
        return Int64(intValue)
    default:
        return 0
    }
}
