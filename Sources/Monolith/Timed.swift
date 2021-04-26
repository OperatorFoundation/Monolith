//
//  Timed.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public class TimedPart<T> where T: ByteType {
    var Milliseconds: UInt
    var Items: [T]
    
    public init(Milliseconds: UInt, Items: [T]) {
        self.Milliseconds = Milliseconds
        self.Items = Items
    }
}

struct TimedMessage {
    let Milliseconds: UInt
    let bytes: [UInt8]
}

