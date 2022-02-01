//
//  Validator.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public enum Validity: String {
    case Valid
    case Invalid
    case Incomplete
}

extension Validity
{
    func String() -> String
    {
        return self.rawValue
    }
}

public protocol Validateable
{
    func Validate(buffer: Buffer, context: inout Context) -> Validity
}

extension Description {
    func Validate(buffer: Buffer, context: inout Context) -> Validity {
        for part in self.Parts {
            let valid = part.Validate(buffer: buffer, context: &context)
            switch valid {
            case .Valid:
                continue
            case .Invalid:
                return .Invalid
            case .Incomplete:
                return .Incomplete
            }
        }
        
        return .Valid
    }
}

extension BytesPart: Validateable
{
    public func Validate(buffer: Buffer, context: inout Context) -> Validity
    {
        for item in self.Items
        {
            let valid = item.Validate(buffer: buffer, context: &context)
            switch valid
            {
                case .Valid:
                    continue
                case .Invalid:
                    return .Invalid
                case .Incomplete:
                    return .Incomplete
            }
        }
        
        return .Valid
    }
}

extension ByteTypeConfig: Validateable
{
    public func Validate(buffer: Buffer, context: inout Context) -> Validity
    {
        switch self
        {
            case .fixed(let fixedByteType):
                return fixedByteType.Validate(buffer: buffer, context: &context)
            case .enumerated(let enumeratedByteType):
                return enumeratedByteType.Validate(buffer: buffer, context: &context)
            case .random(let randomByteType):
                return randomByteType.Validate(buffer: buffer, context: &context)
            case .randomEnumerated(let randomEnumeratedByteType):
                return randomEnumeratedByteType.Validate(buffer: buffer, context: &context)
            case .semanticIntConsumer(let semanticIntConsumerByteType):
                return semanticIntConsumerByteType.Validate(buffer: buffer, context: &context)
            case .semanticIntProducer(let semanticIntProducerByteType):
                return semanticIntProducerByteType.Validate(buffer: buffer, context: &context)
        }
    }
}

extension MonolithConfig: Validateable
{
    public func Validate(buffer: Buffer, context: inout Context) -> Validity
    {
        switch self
        {
            case .bytes(let bytesPart):
                return bytesPart.Validate(buffer: buffer, context: &context)
        }
    }
}

extension FixedByteType: Validateable
{
    public func Validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.Empty()
        {
            return .Incomplete
        }
        
        let (b, popError) = buffer.Pop()
        
        if popError != nil
        {
            return .Invalid
        }
        
        if b == self.Byte
        {
            return .Valid
        }
        else
        {
            return .Invalid
        }
    }
}

extension EnumeratedByteType: Validateable
{
    public func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (b, popError) = buffer.Pop()
        if popError != nil {
            return .Invalid
        }
        
        if self.Options.contains(b)
        {
            return .Valid
        }
        else
        {
            return .Invalid
        }
    }
}

extension RandomByteType: Validateable {
    public func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (_, popError) = buffer.Pop()
        if popError != nil {
            return .Invalid
        }
        return .Valid
    }
}

extension RandomEnumeratedByteType: Validateable {
    public func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (b, popError) = buffer.Pop()
        if popError != nil {
            return .Invalid
        }
        
        if self.RandomOptions.contains(b) {
            return .Valid
        } else {
            return .Invalid
        }
    }
}
