//
//  Args.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public struct Args: Codable
{
    var Values: [ArgValue]
    let Index: Int
}

public enum ArgValue: Codable
{
    case int(Int)
    case byte(UInt8)
}

enum ArgsError: Error
{
    case emptyPopError
    case popValueNotInt
    case popValueNotByte
}

func NewEmptyArgs() -> Args {
    return Args.init(Values: [], Index: 0)
}

func NewArgs(values: [ArgValue]) -> Args
{
    return Args.init(Values: values, Index: 0)
}

func NewIntArgs(values: [Int]) -> Args
{
    let argValues = values.map
    {
        (argValue: Int) -> ArgValue in
        
        return ArgValue.int(argValue)
    }
    
    return Args.init(Values: argValues, Index: 0)
}

func NewByteArgs(values: [Int]) -> Args
{
    let argValues = values.map
    {
        (argValue: Int) -> ArgValue in
        
        return ArgValue.byte(UInt8(argValue))
    }
    
    return Args.init(Values: argValues, Index: 0)
}

extension Args
{
    func Empty() -> Bool
    {
        //self takes the place of the lowercase variable from go 
        return self.Values.count <= 0
    }
    
    mutating func Pop() -> (ArgValue?, Error?) {
        if self.Values.count > 0 {
            let value = self.Values[0]
            let rest = [ArgValue](self.Values[1...])
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
        
        switch value
        {
            case .int(let intValue):
                return (intValue, nil)
            case .byte(let byteValue):
                return(Int(byteValue), nil)
        }
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
        
        switch value {
            case .int(let int):
                let byte = UInt8(int)
                return (byte, nil)
            case .byte(let uint8):
                return (uint8, nil)
        }
    }
    
    mutating func Push(value: ArgValue) {
        self.Values.append(value)
    }
}
