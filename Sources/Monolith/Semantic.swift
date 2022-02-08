//
//  Semantic.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

enum SemanticError: Error {
    case popError
}

public struct SemanticIntProducerByteType: Codable {
    let Name: String
    let Value: ByteTypeConfig
}

public struct SemanticIntConsumerByteType: Codable
{
    let Name: String
}

extension SemanticIntProducerByteType
{
    func Validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.Empty()
        {
            return Validity.Incomplete
        }
        
        let (b, maybeError) = buffer.Pop()
        guard maybeError == nil else
        {
            return .Invalid
        }
        
        let subbuffer = Buffer(value: [b])
        
        if self.Value.Validate(buffer: subbuffer, context: &context) == Validity.Valid
        {
            let intValue = Int(b)
            context.Set(name: self.Name, value: intValue)
            
            return .Valid
        }
        else
        {
            return .Invalid
        }
    }
    
    func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.Empty()
        {
            return
        }
        
        let (b, popError) = buffer.Pop()
        if popError != nil {
            return
        }
        
        let value = Int(b)
        
        context.Set(name: self.Name, value: value)
    }
    
    func Count() -> Int
    {
        return self.Value.Count()
    }
    
    enum ByteFromArgsError: Error
    {
        case byteError
    }
    
    func ByteFromArgs(args: inout Args, context: inout Context) -> (UInt8, Error?)
    {
        let (maybeB, byteError) = self.Value.ByteFromArgs(args: &args, context: &context)
        if byteError != nil {
            return (0, ByteFromArgsError.byteError)
        }
        
        guard let b = maybeB else {
            return (0, ByteFromArgsError.byteError)
        }
        let n = Int(b)
        context.Set(name: self.Name, value: n)
        return (b, nil)
    }
}

extension SemanticIntConsumerByteType {
    func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.Empty() {
            return Validity.Incomplete
        }
        
        let (b, maybeError) = buffer.Pop()
        guard maybeError == nil else {
            return .Invalid
        }
        
        let n = Int(b)
        
        let (value, ok) = context.GetInt(name: self.Name)
        if ok {
            if n == value {
                return .Valid
            } else {
                return .Invalid
            }
        } else {
            return .Invalid
        }
    }
    
    func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.Empty() {
            return
        }
        
        let (b, popError) = buffer.Pop()
        if popError != nil {
            return
        }
        
        let n = Int(b)
        
        let (value, ok) = context.GetInt(name: self.Name)
        if ok {
            if n == value {
                args.Push(value: .int(n))
            }
        }
    }
    
    func Count() -> Int {
        return 1
    }
    
    enum SemanticIntConsumerByteTypeError: Error {
        case undefinedVariableError
    }
    
    func ByteFromArgs(args: inout Args, context: inout Context) -> (UInt8, Error?) {
        let (value, ok) = context.GetInt(name: self.Name)
        if ok {
            return (UInt8(value), nil)
        } else {
            return (0, SemanticIntConsumerByteTypeError.undefinedVariableError)
        }
    }
}
