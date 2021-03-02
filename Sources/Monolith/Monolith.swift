//
//  Monolith.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

typealias Monolith = Messageable & Parseable & Validateable & Countable

struct Description {
    let Parts: [Monolith]
}

protocol Byteable {
    func Bytes() -> [UInt8]
}

protocol Messageable {
    func MessageFromArgs(args: Args, context: Context) -> Message
}

struct BytesPart {
    let Items: [ByteType]
}

typealias ByteType = Validateable & Parseable & Countable //& func ByteFromArgs(args: Args, context: Context) -> (UInt8, Error)

struct FixedByType {
    let Byte: UInt8
}

struct EnumeratedByteType {
    let Options: [UInt8]
}

struct RandomByteType {
    
}

struct RandomEnumeratedByteType {
    let RandomOptions: [UInt8]
}

struct SemanticByteType {
    
}

typealias Message = Byteable

struct BytesMessage {
    var bytes: [UInt8]
}

extension BytesMessage {
    mutating func Bytes() -> [UInt8] {
        return self.bytes
    }
}
