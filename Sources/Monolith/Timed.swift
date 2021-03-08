//
//  Timed.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public class TimedPart {
    var Milliseconds: UInt
    var Items: [ByteType]
    
    public init(Milliseconds: UInt, Items: ByteType) {
        self.Milliseconds = Milliseconds
        self.Items = Items
    }
}

struct TimedMessage {
    let Milliseconds: UInt
    let bytes: [UInt8]
}

