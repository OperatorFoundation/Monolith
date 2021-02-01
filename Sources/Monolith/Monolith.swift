//
//  Monolith.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

protocol Parseable {
    var Messageable,
    var Parseable,
    var Validateable,
    var Countable
}

struct Description {
    let Parts: [Monolith]
}

protocol Byteable {
    var Bytes(): [Byte]
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
    let Byte: Byte
}

struct EnumeratedByteType {
    let Options: [Byte]
}

struct RandomByteType {
    
}

struct RandomEnumeratedByteType {
    let RandomOptions: [Byte]
}

struct SemanticByteType {
    
}

protocol Message {
    val Byteable
}

struct BytesMessage {
    bytes: [Byte]
}
