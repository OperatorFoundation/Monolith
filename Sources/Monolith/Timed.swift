//
//  Timed.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct TimedPart {
    let Milliseconds: UInt
    let Items: [ByteType]
}

struct TimedMessage {
    let Milliseconds: UInt
    let bytes: [UInt8]
}
