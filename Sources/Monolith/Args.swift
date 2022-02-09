//
//  Args.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public struct Args: Codable
{
    var values: [ValueType]
    let index: Int
    
    public init()
    {
        values = []
        index = 0
    }
    
    public init(values: [ValueType], index: Int)
    {
        self.values = values
        self.index = index
    }
    
    public init(intValues: [Int])
    {
        let argValues = intValues.map
        {
            (argValue: Int) -> ValueType in
            
            return ValueType.int(argValue)
        }
        
        self.init(values: argValues, index: 0)
    }
    
    public init(byteValues: [Int])
    {
        let argValues = byteValues.map
        {
            (argValue: Int) -> ValueType in
            
            return ValueType.byte(UInt8(argValue))
        }
        
        self.init(values: argValues, index: 0)
    }
    
    func isEmpty() -> Bool
    {
        return self.values.isEmpty
    }
    
    mutating func pop() -> (ValueType?, Error?)
    {
        if self.values.count > 0
        {
            let value = self.values[0]
            let rest = [ValueType](self.values[1...])
            self.values = rest
            
            return (value, nil)
        }
        else
        {
            return (nil, Error.emptyPopError)
        }
    }
    
    mutating func popInt() -> (Int?, Error?)
    {
        let (maybeValue, maybeError) = self.pop()
        
        if let error = maybeError
        {
            return (nil, error)
        }
        
        guard let value = maybeValue else
        {
            return (nil, Error.emptyPopError)
        }
        
        switch value
        {
            case .int(let intValue):
                return (intValue, nil)
            case .byte(let byteValue):
                return(Int(byteValue), nil)
        }
    }
    
    mutating func popByte() -> (UInt8?, Error?)
    {
        let (maybeValue, maybeError) = self.pop()
        if let error = maybeError
        {
            return (nil, error)
        }
        
        guard let value = maybeValue else
        {
            return (nil, Error.emptyPopError)
        }
        
        switch value
        {
            case .int(let int):
                return (UInt8(int), nil)
            case .byte(let uint8):
                return (uint8, nil)
        }
    }
    
    mutating func push(value: ValueType)
    {
        self.values.append(value)
    }
    
    public enum Error: LocalizedError
    {
        case emptyPopError
        //case popValueNotByte
        //case popValueNotInt
        
        
        public var errorDescription: String?
        {
            switch self
            {
                case .emptyPopError:
                    return "Attempted to pop a value from an empty Args value array."
            }
        }
    }
    
    public enum ValueType: Codable
    {
        case int(Int)
        case byte(UInt8)
    }
}




