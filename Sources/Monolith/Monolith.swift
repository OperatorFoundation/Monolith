//
//  Monolith.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

protocol Monolith {
    var Messageable,
    var Parseable,
    var Validateable,
    var Countable
}

struct Description {
    let Parts: [Monolith]
}

protocol Byteable {
    var Bytes(): [UInt8]
}

protocol Messageable {
    MessageFromArgs(args: Args, context, Context) -> Message
}

struct BytesPart {
    let Items: [ByteType]
}

protocol ByteType {
    var Validateable
    var Parseable
    var Countable
    ByteFromArgs(args: Args, context: Context) -> (Byte, Error)
}

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

protocol Message {
    let Byteable
}

struct BytesMessage {
    bytes: [UInt8]
}
