//
//  Monolith.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public typealias Monolith = Messageable & Parseable & Validateable & Countable

public struct Description {
    let Parts: [Monolith]
}

public protocol Byteable {
    mutating func Bytes() -> [UInt8]
}

public protocol Messageable {
    func MessageFromArgs(args: Args, context: Context) -> Message?
}

public struct BytesPart<T> where T: ByteType {
    let Items: [T]
}

public protocol ByteFromArgsable {
    func ByteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
}
public typealias ByteType = Validateable & Parseable & Countable & ByteFromArgsable

public struct FixedByteType {
    let Byte: UInt8
}

public struct EnumeratedByteType {
    let Options: [UInt8]
}

public struct RandomByteType {
    
}

public struct RandomEnumeratedByteType {
    let RandomOptions: [UInt8]
}

public struct SemanticByteType {
    
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
