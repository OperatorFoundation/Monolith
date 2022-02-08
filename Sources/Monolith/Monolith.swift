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
    let Parts: [MonolithConfig]
}

public protocol Byteable
{
    mutating func Bytes() -> [UInt8]
}

public protocol Messageable: Codable
{
    func MessageFromArgs(args: inout Args, context: inout Context) -> Message?
}

public struct BytesPart: Codable
{
    let Items: [ByteTypeConfig]
}

public protocol ByteFromArgsable
{
    func ByteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
}

extension ByteTypeConfig: ByteFromArgsable
{
    public func ByteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
    {
        switch self
        {
            case .enumerated(let value):
                return value.ByteFromArgs(args: &args, context: &context)
            case .fixed(let value):
                return value.ByteFromArgs(args: &args, context: &context)
            case .random(let value):
                return value.ByteFromArgs(args: &args, context: &context)
            case .randomEnumerated(let value):
                return value.ByteFromArgs(args: &args, context: &context)
            case .semanticIntConsumer(let value):
                return value.ByteFromArgs(args: &args, context: &context)
            case .semanticIntProducer(let value):
                return value.ByteFromArgs(args: &args, context: &context)
        }
    }
}

public typealias ByteType = Validateable & Parseable & Countable & ByteFromArgsable

public struct FixedByteType: Codable {
    let Byte: UInt8
}

public struct EnumeratedByteType: Codable {
    let Options: [UInt8]
}

public struct RandomByteType: Codable {
    
}

public struct RandomEnumeratedByteType: Codable {
    let RandomOptions: [UInt8]
}

public struct SemanticByteType: Codable {
    
}

public typealias Message = Byteable

public struct BytesMessage: Equatable {
    var bytes: [UInt8]
}

extension BytesMessage: Byteable {
    mutating public func Bytes() -> [UInt8] {
        return self.bytes
    }
}
