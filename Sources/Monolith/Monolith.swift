//
//  Monolith.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public typealias Monolith = Messageable & Parseable & Validateable & Countable & Codable

public indirect enum ByteTypeConfig: Codable
{
    case fixed(FixedByteType)
    case enumerated(EnumeratedByteType)
    case random(RandomByteType)
    case randomEnumerated(RandomEnumeratedByteType)
    case semanticIntConsumer(SemanticIntConsumerByteType)
    case semanticIntProducer(SemanticIntProducerByteType)
}

public enum MonolithConfig: Codable
{
    case bytes(BytesPart)
}

public struct Description: Codable
{
    public let parts: [MonolithConfig]
    
    public init(parts: [MonolithConfig])
    {
        self.parts = parts
    }
}

public protocol Byteable
{
    mutating func bytes() -> [UInt8]
}

public protocol Messageable
{
    func messageFromArgs(args: inout Args, context: inout Context) -> Message?
}

public struct BytesPart: Codable
{
    public let items: [ByteTypeConfig]
    
    public init(items: [ByteTypeConfig])
    {
        self.items = items
    }
}

public protocol ByteFromArgsable
{
    func byteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
}

extension ByteTypeConfig: ByteFromArgsable
{
    public func byteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
    {
        switch self
        {
            case .enumerated(let value):
                return value.byteFromArgs(args: &args, context: &context)
            case .fixed(let value):
                return value.byteFromArgs(args: &args, context: &context)
            case .random(let value):
                return value.byteFromArgs(args: &args, context: &context)
            case .randomEnumerated(let value):
                return value.byteFromArgs(args: &args, context: &context)
            case .semanticIntConsumer(let value):
                return value.byteFromArgs(args: &args, context: &context)
            case .semanticIntProducer(let value):
                return value.byteFromArgs(args: &args, context: &context)
        }
    }
}

public typealias ByteType = Validateable & Parseable & Countable & ByteFromArgsable

public struct FixedByteType: Codable
{
    public let byte: UInt8
    
    public init(byte: UInt8)
    {
        self.byte = byte
    }
}

public struct EnumeratedByteType: Codable
{
    public let options: [UInt8]
    
    public init(options: [UInt8])
    {
        self.options = options
    }
}

public struct RandomByteType: Codable
{
    public init() {}
}

public struct RandomEnumeratedByteType: Codable
{
    public let randomOptions: [UInt8]
    
    public init(randomOptions: [UInt8])
    {
        self.randomOptions = randomOptions
    }
}

public struct SemanticByteType: Codable
{
    public init() {}
}

public typealias Message = Byteable

public struct BytesMessage: Message, Equatable
{
    public var messageBytes: [UInt8]
    
    public mutating func bytes() -> [UInt8]
    {
        return self.messageBytes
    }
}

