//
//  Validator.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public enum Validity: String
{
    case valid
    case invalid
    case incomplete
    
    func string() -> String
    {
        return self.rawValue
    }
}

public protocol Validateable
{
    func validate(buffer: Buffer, context: inout Context) -> Validity
}

extension Description: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        for part in self.parts
        {
            let valid = part.validate(buffer: buffer, context: &context)
            
            switch valid
            {
                case .valid:
                    continue
                case .invalid:
                    return .invalid
                case .incomplete:
                    return .incomplete
            }
        }
        
        return .valid
    }
}

extension BytesPart: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        for item in self.items
        {
            let valid = item.validate(buffer: buffer, context: &context)
            
            switch valid
            {
                case .valid:
                    continue
                case .invalid:
                    return .invalid
                case .incomplete:
                    return .incomplete
            }
        }
        
        return .valid
    }
}

extension ByteTypeConfig: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        switch self
        {
            case .fixed(let fixedByteType):
                return fixedByteType.validate(buffer: buffer, context: &context)
            case .enumerated(let enumeratedByteType):
                return enumeratedByteType.validate(buffer: buffer, context: &context)
            case .random(let randomByteType):
                return randomByteType.validate(buffer: buffer, context: &context)
            case .randomEnumerated(let randomEnumeratedByteType):
                return randomEnumeratedByteType.validate(buffer: buffer, context: &context)
            case .semanticIntConsumer(let semanticIntConsumerByteType):
                return semanticIntConsumerByteType.validate(buffer: buffer, context: &context)
            case .semanticIntProducer(let semanticIntProducerByteType):
                return semanticIntProducerByteType.validate(buffer: buffer, context: &context)
        }
    }
}

extension MonolithConfig: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        switch self
        {
            case .bytes(let bytesPart):
                return bytesPart.validate(buffer: buffer, context: &context)
        }
    }
}

extension FixedByteType: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .incomplete
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
        {
            return .invalid
        }
        
        if first == self.byte
        {
            return .valid
        }
        else
        {
            return .invalid
        }
    }
}

extension EnumeratedByteType: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .incomplete
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
        {
            return .invalid
        }
        
        if self.options.contains(first)
        {
            return .valid
        }
        else
        {
            return .invalid
        }
    }
}

extension RandomByteType: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .incomplete
        }
        
        let maybeFirst = buffer.pop()
        
        if maybeFirst == nil
        {
            return .invalid
        }
        
        return .valid
    }
}

extension RandomEnumeratedByteType: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .incomplete
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
        {
            return .invalid
        }
        
        if self.randomOptions.contains(first)
        {
            return .valid
        }
        else
        {
            return .invalid
        }
    }
}

extension SemanticIntProducerByteType: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .incomplete
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
        {
            return .invalid
        }
        
        let subbuffer = Buffer(value: [first])
        
        if self.value.validate(buffer: subbuffer, context: &context) == Validity.valid
        {
            let intValue = Int(first)
            context.set(name: self.name, value: intValue)
            
            return .valid
        }
        else
        {
            return .invalid
        }
    }
}

extension SemanticIntConsumerByteType: Validateable
{
    public func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .incomplete
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
            { return .invalid }
        
        let n = Int(first)
        
        let (value, ok) = context.getInt(name: self.name)
        
        if ok
        {
            if n == value
            {
                return .valid
            }
            else
            {
                return .invalid
            }
        }
        else
        {
            return .invalid
        }
    }
}
