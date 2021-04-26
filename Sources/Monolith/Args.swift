//
//  Args.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public struct Args {
    var Values: [Any]
    let Index: Int
}

enum ArgsError: Error {
    case emptyPopError
    case popValueNotInt
    case popValueNotByte
}

func NewEmptyArgs() -> Args {
    return Args.init(Values: [], Index: 0)
}

func NewArgs(values: [Any]) -> Args {
    return Args.init(Values: values, Index: 0)
}

extension Args {
    func Empty() -> Bool{
        //self takes the place of the lowercase variable from go 
        return self.Values.count <= 0
    }
    
    mutating func Pop() -> (Any?, Error?) {
        if self.Values.count > 0 {
            let value = self.Values[0]
            let rest = [Any](self.Values[1...])
            self.Values = rest
            return (value, nil)
        } else {
            return (nil, ArgsError.emptyPopError)
        }
    }
    
    mutating func PopInt() -> (Int?, Error?) {
        //destructuring example below
        let (maybeValue, maybeError) = self.Pop()
        if let error = maybeError {
            return (nil, error)
        }
        
        guard let value = maybeValue else {
            return (nil, ArgsError.emptyPopError)
        }
        
        guard let intValue = value as? Int else {
            return (nil, ArgsError.popValueNotInt)
        }
        
        return (intValue, nil)
    }
    
    mutating func PopByte() -> (UInt8?, Error?) {
        let (maybeValue, maybeError) = self.Pop()
        if let error = maybeError {
            return (nil, error)
        }
        
        // guard = i expect this to be true, otherwise bail out
        // if = if this is true, continue
        guard let value = maybeValue else {
            return (nil, ArgsError.emptyPopError)
        }
        
        if let intValue = value as? Int {
            let byte = UInt8(intValue)
            return (byte, nil)
        }
        
        if let byteValue = value as? UInt8 {
            return (byteValue, nil)
        }
        
        return (nil, ArgsError.popValueNotByte)
    }
    
    mutating func Push(value: Any) {
        self.Values.append(value)
    }
}
