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
        if buffer.isEmpty()
        {
            return Validity.Incomplete
        }
        
        let (b, maybeError) = buffer.pop()
        guard maybeError == nil else
        {
            return .Invalid
        }
        
        let subbuffer = Buffer(value: [b])
        
        if self.Value.Validate(buffer: subbuffer, context: &context) == Validity.Valid
        {
            let intValue = Int(b)
            context.set(name: self.Name, value: intValue)
            
            return .Valid
        }
        else
        {
            return .Invalid
        }
    }
    
    func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let (b, popError) = buffer.pop()
        if popError != nil {
            return
        }
        
        let value = Int(b)
        
        context.set(name: self.Name, value: value)
    }
    
    
}

extension SemanticIntConsumerByteType
{
    func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.isEmpty() {
            return Validity.Incomplete
        }
        
        let (b, maybeError) = buffer.pop()
        guard maybeError == nil else {
            return .Invalid
        }
        
        let n = Int(b)
        
        let (value, ok) = context.getInt(name: self.Name)
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
        if buffer.isEmpty() {
            return
        }
        
        let (b, popError) = buffer.pop()
        if popError != nil {
            return
        }
        
        let n = Int(b)
        
        let (value, ok) = context.getInt(name: self.Name)
        if ok {
            if n == value {
                args.push(value: .int(n))
            }
        }
    }
    
}
